import 'dart:math';
import 'package:flutter/material.dart';
import '../game_engine/ether_world_widget.dart';   // ← правильный импорт

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
    _a = rng.nextInt(20) + 10;
    _b = rng.nextInt(20) + 10;
  }

  void _checkAnswer() {
    final correct = _a + _b;
    final answer = int.tryParse(_answerController.text);
    if (answer == correct) {
      // Переход сразу к игре
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const EtherWorldWidget()),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Неверно, попробуйте ещё раз')),
      );
      _generateMath();
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(32.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('Родительский доступ',
                  style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold)),
              const SizedBox(height: 40),
              Text('Сколько будет $_a + $_b?',
                  style: const TextStyle(fontSize: 48)),
              TextField(
                controller: _answerController,
                keyboardType: TextInputType.number,
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 48),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _checkAnswer,
                child: const Text('Подтвердить', style: TextStyle(fontSize: 36)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}