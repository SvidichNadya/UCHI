import 'package:flutter/material.dart';
import 'package:flame/game.dart';
import 'game_world.dart';

class EtherWorldWidget extends StatefulWidget {
  const EtherWorldWidget({super.key});

  @override
  State<EtherWorldWidget> createState() => _EtherWorldWidgetState();
}

class _EtherWorldWidgetState extends State<EtherWorldWidget> {
  late EtherWorld _game;

  @override
  void initState() {
    super.initState();
    _game = EtherWorld();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Сам игровой движок (Канвас Flame)
          GameWidget(game: _game),
          
          // Верхняя панель (Энергия и настройки)
          Positioned(
            top: 20,
            left: 20,
            right: 20,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.6),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const Row(
                    children: [
                      Icon(Icons.bolt, color: Colors.amber, size: 36),
                      SizedBox(width: 10),
                      Text('Энергия: 100', style: TextStyle(color: Colors.white, fontSize: 24)),
                    ],
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.close, color: Colors.white, size: 40),
                  onPressed: () => Navigator.pop(context), // Выход в главное меню
                )
              ],
            ),
          ),

          // Нижняя панель действий (Выбор: Читать или Спорт)
          Positioned(
            bottom: 40,
            left: 0,
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildActionButton(
                  'Прочитать Сказку', 
                  Icons.menu_book, 
                  Colors.blueAccent,
                  () => _game.handleVoiceCommand('читать')
                ),
                _buildActionButton(
                  'Разминка', 
                  Icons.sports_gymnastics, 
                  Colors.orangeAccent,
                  () => _game.handleVoiceCommand('спорт')
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _buildActionButton(String label, IconData icon, Color color, VoidCallback onTap) {
    return ElevatedButton.icon(
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        foregroundColor: Colors.white,
        minimumSize: const Size(280, 80), // Увеличенные touch-targets (60+ pt)
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
        elevation: 6,
      ),
      icon: Icon(icon, size: 36),
      label: Text(label, style: const TextStyle(fontSize: 26, fontWeight: FontWeight.bold)),
      onPressed: onTap,
    );
  }
}