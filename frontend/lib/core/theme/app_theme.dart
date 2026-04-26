import 'package:flutter/material.dart';

/// Глобальный класс дизайн-система приложения
class AppTheme {
  // --- ЦВЕТОВАЯ ПАЛИТРА ---
  // Фирменные цвета 
  static const Color primaryTeal = Color(0xFF064868); 
  static const Color brandPink = Color(0xFFFF5767); 
  
  // Фоны и сервисные цвета
  static const Color bgStudent = Color(0xFFF4F2FC); // Светлый фон кабинета
  static const Color secondaryPurple = Color(0xFFE6E0F8); // Второстепенный для низкого приоритета
  
  // Текст (Смесь 80% фиолетового и 20% красного, вместо чистого серого)
  static const Color textMain = Color(0xFF2B1A3A); 
  
  // Системные уведомления
  static const Color successGreen = Color(0xFF27AE60);
  static const Color errorRed = Color(0xFFEB5757);

  // --- СИСТЕМА ОТСТУПОВ (Модуль 4px) ---
  static const double m1 = 4.0;
  static const double m2 = 8.0;
  static const double m3 = 12.0;
  static const double m4 = 16.0;
  static const double m6 = 24.0;
  static const double m8 = 32.0;
  static const double m10 = 40.0;

  // --- СКРУГЛЕНИЯ (Border Radius) ---
  // Внешние контентные блоки (>= 96px)
  static final BorderRadius radiusBlock = BorderRadius.circular(32.0); 
  // Элементы внутри блоков
  static final BorderRadius radiusInner = BorderRadius.circular(16.0); 
  // Малые изолированные элементы (<= 95px)
  static final BorderRadius radiusSmall = BorderRadius.circular(24.0); 

  // --- ТЕНИ (Shadows) ---
  static final List<BoxShadow> baseShadow =;

  // --- ТИПОГРАФИКА ---
  static const TextTheme textTheme = TextTheme(
    displayLarge: TextStyle(fontSize: 40, height: 46/40, fontWeight: FontWeight.w700, color: textMain), // H1
    displayMedium: TextStyle(fontSize: 32, height: 38/32, fontWeight: FontWeight.w700, color: textMain), // H2
    displaySmall: TextStyle(fontSize: 24, height: 30/24, fontWeight: FontWeight.w700, color: textMain), // H3
    bodyLarge: TextStyle(fontSize: 16, height: 24/16, fontWeight: FontWeight.w400, color: textMain), // Body Large
    bodyMedium: TextStyle(fontSize: 14, height: 20/14, fontWeight: FontWeight.w400, color: textMain), // Body
  );

  // --- ГЕНЕРАЦИЯ ТЕМЫ ДЛЯ FLUTTER ---
  static ThemeData get themeData {
    return ThemeData(
      primaryColor: primaryTeal,
      scaffoldBackgroundColor: bgStudent,
      textTheme: textTheme,
      fontFamily: 'Nunito', // Округлый шрифт без засечек для детского интерфейса
      
      // Глобальный стиль кнопок (с учетом Touch Targets для детей)
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: primaryTeal,
          foregroundColor: Colors.white,
          minimumSize: const Size(64, 64), // Увеличенная зона клика
          padding: const EdgeInsets.symmetric(horizontal: m6, vertical: m4),
          shape: RoundedRectangleBorder(borderRadius: radiusSmall),
          elevation: 0,
          textStyle: textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.w700),
        ),
      ),
      
      // Глобальный стиль карточек-контейнеров
      cardTheme: CardTheme(
        color: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: radiusBlock),
        elevation: 0, // Тень добавляется через Container, если нужно
        margin: EdgeInsets.zero,
      ),
    );
  }
}