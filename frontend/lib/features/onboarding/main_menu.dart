import 'package:flutter/material.dart';
import 'parent_gate.dart';
import '../game_engine/ether_world_widget.dart';

class MainMenuScreen extends StatelessWidget {
  const MainMenuScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Color(0xFF4A00E0), Color(0xFF8E2DE2)], // Мистический эфирный фон
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'ХРАНИТЕЛИ ЭФИРА',
                style: TextStyle(
                  fontSize: 64,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  letterSpacing: 4,
                ),
              ),
              const SizedBox(height: 60),
              // Кнопка для ребенка (сразу в игру/калибровку)
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.amberAccent,
                  foregroundColor: Colors.black87,
                  minimumSize: const Size(350, 90),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(40),
                  ),
                  elevation: 8,
                ),
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (_) => const EtherWorldWidget()),
                  );
                },
                child: const Text('ИГРАТЬ', style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold)),
              ),
              const SizedBox(height: 30),
              // Кнопка для родителя (в дашборд через гейт)
              TextButton.icon(
                icon: const Icon(Icons.admin_panel_settings, color: Colors.white70, size: 32),
                label: const Text(
                  'Родительская панель',
                  style: TextStyle(fontSize: 28, color: Colors.white70),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const ParentGateScreen()),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}