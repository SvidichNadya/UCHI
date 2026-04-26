import 'package:flutter/material.dart';
import '../../core/theme/uchi_tokens.dart';
import 'parent_gate_screen.dart';

class MainMenuScreen extends StatelessWidget {
  const MainMenuScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          // Фоновое изображение на весь экран (превью мира)
          Image.network(
            'ВСТАВЬТЕ_ССЫЛКУ_НА_КАРТИНКУ_ИЗ_ОТВЕТА_ВЫШЕ', 
            fit: BoxFit.cover,
          ),
          
          // Темный градиент снизу для глубины и контраста
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.transparent,
                  Colors.black.withOpacity(0.3),
                ],
              ),
            ),
          ),
          
          // Центральный UI-блок
          Center(
            child: Container(
              constraints: const BoxConstraints(maxWidth: 480), // Ограничение ширины
              padding: const EdgeInsets.all(UchiTokens.m8), // Отступ 32px
              decoration: BoxDecoration(
                color: UchiTokens.white100.withOpacity(0.95), // Белая плашка с легкой прозрачностью
                borderRadius: BorderRadius.circular(UchiTokens.radiusBlock), // Скругление 32px
                boxShadow: UchiTokens.shadowBase, // Базовая тень
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Название игры
                  Text(
                    "Хранители Эфира",
                    style: textTheme.displayLarge?.copyWith(
                      color: UchiTokens.primary, // Фирменный темно-синий
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: UchiTokens.m4), // 16px
                  
                  // Слоган
                  Text(
                    "Оживи магию своими движениями!",
                    style: textTheme.bodyLarge?.copyWith(
                      color: UchiTokens.text60,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: UchiTokens.m8), // 32px
                  
                  // Кнопка "ИГРАТЬ" (увеличенная зона нажатия для детей)
                  SizedBox(
                    width: double.infinity,
                    height: 64, // Touch target > 60pt для инклюзивного детского UX
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: UchiTokens.brand, // Розовый акцентный цвет (brand)
                        foregroundColor: UchiTokens.white100,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(UchiTokens.radiusElement), // Скругление 16px
                        ),
                        elevation: 0,
                      ),
                      onPressed: () {
                        // TODO: Навигация на экран калибровки камеры / начала игры
                      },
                      child: const Text(
                        "ИГРАТЬ",
                        style: TextStyle(
                          fontSize: 24, 
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1.2,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: UchiTokens.m4), // 16px
                  
                  // Менее заметная кнопка для родителей
                  TextButton(
                    style: TextButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                        vertical: UchiTokens.m4, 
                        horizontal: UchiTokens.m6,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(UchiTokens.radiusElement),
                      ),
                    ),
                    onPressed: () {
                      // Переход на защищенный экран (Parent Gate)
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const ParentGateScreen(),
                        ),
                      );
                    },
                    child: const Text(
                      "Вход для родителей",
                      style: TextStyle(
                        color: UchiTokens.text60, // Приглушенный цвет 60%
                        fontSize: 16,
                        decoration: TextDecoration.underline, // Подчеркивание для интуитивности
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}