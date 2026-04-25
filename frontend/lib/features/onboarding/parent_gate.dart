import 'dart:math';
import 'package:flutter/material.dart';
import '../parent_dashboard/dashboard.dart'; // Путь к дашборду из вашей структуры

class ParentGateScreen extends StatefulWidget {
  const ParentGateScreen({super.key});

  @override
  State<ParentGateScreen> createState() => _ParentGateScreenState();
}

class _ParentGateScreenState extends State<ParentGateScreen> {
  final _answerController = TextEditingController();
  int _a = 0, _b = 0;

  @override
  void initState() {
    super.initState();
    _generateMath();
  }

  void _generateMath() {
    final rng = Random();
    _a = rng.nextInt(20) + 10; // Двузначные числа по концепту
    _b = rng.nextInt(20) + 10;
  }

  void _checkAnswer() {
      final correct = _a + _b;
      final answer = int.tryParse(_answerController.text);
      if (answer == correct) {
        // Идем в дашборд (класс называется DashboardScreen)
        Navigator.pushReplacement(
          context,
          // Передаем childId (заглушка 1 для теста)
          MaterialPageRoute(builder: (_) => const DashboardScreen(childId: 1)), 
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Неверно. Убедитесь, что вы взрослый!'),
            backgroundColor: Colors.redAccent,
          ),
        );
        _answerController.clear();
        _generateMath();
        setState(() {});
      }
    }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Доступ для родителей')),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(32.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.security, size: 80, color: Colors.deepPurple),
              const SizedBox(height: 20),
              const Text(
                'Для доступа к аналитике решите пример:',
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 40),
              Text('$_a + $_b = ?', style: const TextStyle(fontSize: 48)),
              const SizedBox(height: 20),
              SizedBox(
                width: 200,
                child: TextField(
                  controller: _answerController,
                  keyboardType: TextInputType.number,
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 40),
                  decoration: const InputDecoration(border: OutlineInputBorder()),
                ),
              ),
              const SizedBox(height: 30),
              ElevatedButton(
                onPressed: _checkAnswer,
                style: ElevatedButton.styleFrom(minimumSize: const Size(200, 60)),
                child: const Text('Войти', style: TextStyle(fontSize: 28)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}