import 'dart:js_interop';
import 'package:flame/game.dart';
import 'package:flame/events.dart';
import 'package:web/web.dart' as web;
import '../../phygital_core/ml_interop/mediapipe_task.dart';
import '../../phygital_core/kinematics/avatar_controller.dart';
import '../../phygital_core/speech/speech_handler.dart';

class EtherWorld extends FlameGame with TapCallbacks {
  late AvatarController avatar;
  late MediaPipePoseDetector poseDetector;
  late SpeechHandler speechHandler;
  late web.HTMLVideoElement video;
  String currentTask = 'idle';

  @override
  Future<void> onLoad() async {
    // ----- Камера -----
    video = web.document.createElement('video') as web.HTMLVideoElement;
    video.autoplay = true;
    video.playsInline = true;
    video.width = 640;
    video.height = 480;

    final constraints = web.MediaStreamConstraints()
      ..video = true.jsify()!;            // JSAny? -> JSAny через !
    final promise = web.window.navigator.mediaDevices.getUserMedia(constraints);
    final stream = await promise.toDart;  // MediaStream
    video.srcObject = stream;
    await video.play().toDart;

    // ----- MediaPipe детектор -----
    poseDetector = await MediaPipePoseDetector.create();

    // ----- Аватар -----
    avatar = AvatarController();
    add(avatar);

    // ----- Голос -----
    speechHandler = SpeechHandler(
      onCommand: (command) => handleVoiceCommand(command),
    );
    speechHandler.start();

    // ----- Цикл детекции -----
    Stream.periodic(const Duration(milliseconds: 100)).listen((_) {
      final landmarks = poseDetector.detect(video);
      if (landmarks != null) {
        avatar.updatePose(landmarks);
      }
    });
  }

  void handleVoiceCommand(String command) {
    if (command.contains('читать')) {
      // startReadingChallenge();
    } else if (command.contains('спорт')) {
      // startExercise('squats');
    } else if (command.contains('лепить')) {
      // startCraft();
    }
  }

  @override
  void update(double dt) {
    super.update(dt);
    avatar.updateAnimation(dt);
  }

  @override
  void onRemove() {
    final stream = video.srcObject as web.MediaStream?;
    if (stream != null) {
      final tracks = stream.getTracks();
      for (int i = 0; i < tracks.length; i++) {
        tracks[i].stop();
      }
    }
    video.srcObject = null;
    super.onRemove();
  }
}