import 'package:flutter/material.dart';
import 'core/theme/uchi_theme.dart';
import 'features/onboarding/main_menu.dart';

void main() {
  // Запуск кроссплатформенного приложения
  runApp(const EtherGuardiansApp());
}

class EtherGuardiansApp extends StatelessWidget {
  const EtherGuardiansApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Ether Guardians',
      theme: UchiTheme.light, // Применяем глобальный стилевой шаблон
      home: const MainMenuScreen(), // Стартовый экран изменен на Главное меню
      debugShowCheckedModeBanner: false, // Убираем бейдж "Debug"
    );
  }
}