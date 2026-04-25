import 'dart:js_interop';
import 'package:flutter/material.dart'; // <- Используем material.dart вместо dart:ui
import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:web/web.dart' as web;
// Ваши импорты ML и аватара остаются здесь

class EtherWorld extends FlameGame {
  // late AvatarController avatar;
  late web.HTMLVideoElement video;
  String currentTask = 'idle';

  @override
  Future<void> onLoad() async {
    super.onLoad();
    
    // 1. Отрисовка фона (Мистический лес)
    add(RectangleComponent(
      size: size,
      paint: Paint()..color = const Color(0xFF1E1E2C),
    ));

    // 2. Добавление NPC: Каменный Голем
    add(CircleComponent(
      radius: 80,
      position: Vector2(size.x / 2, size.y / 2.5),
      anchor: Anchor.center,
      paint: Paint()..color = const Color(0xFF5A636A),
    ));

    // 3. Добавление текста над Големом
    add(TextComponent(
      text: 'Я Каменный Голем! Как пройдем?',
      position: Vector2(size.x / 2, size.y / 2.5 - 110),
      anchor: Anchor.center,
      textRenderer: TextPaint(
        // Теперь Flutter TextStyle будет распознан корректно
        style: const TextStyle(fontSize: 32, color: Color(0xFFFFFFFF), fontWeight: FontWeight.bold),
      ),
    ));

    _initializeCamera();
  }

  Future<void> _initializeCamera() async {
    try {
      video = web.document.createElement('video') as web.HTMLVideoElement;
      video.autoplay = true;
      video.playsInline = true;
      video.width = 640;
      video.height = 480;

      final constraints = web.MediaStreamConstraints()..video = true.jsify()!;
      final promise = web.window.navigator.mediaDevices.getUserMedia(constraints);
      final stream = await promise.toDart;
      video.srcObject = stream;
      await video.play().toDart;
      
      // Здесь инициализируется ваш MediaPipe
    } catch (e) {
      print('Ошибка доступа к камере: $e');
    }
  }

  void handleVoiceCommand(String command) {
    if (command.contains('читать')) {
      print('Инициирован сценарий Чтения');
      // Смена состояния: запускаем мини-игру с рунами
    } else if (command.contains('спорт')) {
      print('Инициирован сценарий Спорта');
      // Смена состояния: падающие камни
    }
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
    super.onRemove();
  }
}