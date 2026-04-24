import 'dart:math';
import 'package:flame/components.dart';

class AvatarController extends SpriteAnimationComponent with HasGameReference {
  Map<String, List<double>>? currentPose;

  @override
  Future<void>? onLoad() {
    // animation будет загружена позже, пока заглушка
    return null;
  }

  void updatePose(Map<String, List<double>> landmarks) {
    currentPose = landmarks.map((k, v) => MapEntry(k, List<double>.from(v)));
    // Пример: перемещаем аватар в позицию левой руки
    if (landmarks.containsKey('left_wrist')) {
      final wrist = landmarks['left_wrist']!;
      position = Vector2(wrist[0] * game.size.x, wrist[1] * game.size.y);
    }
  }

  void updateAnimation(double dt) {
    // Плавное изменение анимации (заглушка)
  }
}

class Kinematics {
  static double calculateAngle(
    List<double> a, List<double> b, List<double> c,
  ) {
    final ba = [a[0]-b[0], a[1]-b[1], a[2]-b[2]];
    final bc = [c[0]-b[0], c[1]-b[1], c[2]-b[2]];
    final dot = ba[0]*bc[0] + ba[1]*bc[1] + ba[2]*bc[2];
    final magBA = sqrt(ba[0]*ba[0] + ba[1]*ba[1] + ba[2]*ba[2]);
    final magBC = sqrt(bc[0]*bc[0] + bc[1]*bc[1] + bc[2]*bc[2]);
    return acos(dot / (magBA * magBC)) * 180 / pi;
  }
}