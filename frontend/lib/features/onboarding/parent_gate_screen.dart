import 'package:flutter/material.dart';
import 'package:ether_guardians/core/theme/app_theme.dart';
import 'dart:math';

class ParentGateScreen extends StatefulWidget {
  const ParentGateScreen({super.key});

  @override
  State<ParentGateScreen> createState() => _ParentGateScreenState();
}

class _ParentGateScreenState extends State<ParentGateScreen> {
  late int _valA;
  late int _valB;
  final TextEditingController _controller = TextEditingController();
  bool _hasError = false;

  @override
  void initState() {
    super.initState();
    _generateMathProblem();
  }

  void _generateMathProblem() {
    final random = Random();
    _valA = random.nextInt(10) + 11; // 11-20
    _valB = random.nextInt(10) + 2;  // 2-11
  }

  void _validateAndProceed() {
    final int? answer = int.tryParse(_controller.text);
    if (answer!= null && answer == (_valA * _valB)) {
      // Успех: логика перехода в меню/игру
    } else {
      setState(() {
        _hasError = true;
        _controller.clear();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Центрирование контента в рамках максимальной ширины
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 480), // Ограничение по ширине
          child: Container(
            padding: const EdgeInsets.all(AppTheme.m8), // Отступ 32px
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: AppTheme.radiusBlock, // Внешнее скругление 32px
              boxShadow: AppTheme.baseShadow,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children:,
            ),
          ),
        ),
      ),
    );
  }
}