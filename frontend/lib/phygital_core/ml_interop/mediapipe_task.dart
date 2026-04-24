import 'dart:convert';
import 'dart:js_interop';

@JS('createPoseDetector')
external JSPromise<JSAny?> _createPoseDetector();

@JS('getPoseData')
external JSString _getPoseData(JSAny video);

class MediaPipePoseDetector {
  static MediaPipePoseDetector? _instance;

  static Future<MediaPipePoseDetector> create() async {
    if (_instance != null) return _instance!;
    // Ждём, пока глобальная функция createPoseDetector станет доступна
    while (true) {
      try {
        _createPoseDetector(); // вызов сгенерирует исключение, если функции нет
        break;
      } catch (_) {
        await Future.delayed(const Duration(milliseconds: 200));
      }
    }
    final promise = _createPoseDetector();
    await promise.toDart;   // ожидаем завершения инициализации детектора
    _instance = MediaPipePoseDetector._();
    return _instance!;
  }

  MediaPipePoseDetector._();

  Map<String, List<double>>? detect(JSAny videoElement) {
    final jsStr = _getPoseData(videoElement);
    final jsonStr = jsStr.toDart;
    if (jsonStr.isEmpty) return null;
    final List<dynamic> landmarksList = jsonDecode(jsonStr);
    if (landmarksList.isEmpty) return null;
    final pose = landmarksList[0] as Map<String, dynamic>;
    const bodyParts = [
      'nose', 'left_eye_inner', 'left_eye', 'left_eye_outer',
      'right_eye_inner', 'right_eye', 'right_eye_outer',
      'left_ear', 'right_ear', 'mouth_left', 'mouth_right',
      'left_shoulder', 'right_shoulder', 'left_elbow', 'right_elbow',
      'left_wrist', 'right_wrist', 'left_pinky', 'right_pinky',
      'left_index', 'right_index', 'left_thumb', 'right_thumb',
      'left_hip', 'right_hip', 'left_knee', 'right_knee',
      'left_ankle', 'right_ankle', 'left_heel', 'right_heel',
      'left_foot_index', 'right_foot_index'
    ];
    final result = <String, List<double>>{};
    for (final part in bodyParts) {
      if (pose.containsKey(part)) {
        final point = pose[part];
        if (point is Map &&
            point.containsKey('x') &&
            point.containsKey('y') &&
            point.containsKey('z')) {
          result[part] = [
            (point['x'] as num).toDouble(),
            (point['y'] as num).toDouble(),
            (point['z'] as num).toDouble(),
          ];
        }
      }
    }
    return result.isEmpty ? null : result;
  }
}