import 'package:flutter/material.dart';
import 'package:flame/flame.dart';
import 'features/onboarding/parent_gate.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Flame.device.fullScreen();
  runApp(const EtherApp());
}

class EtherApp extends StatelessWidget {
  const EtherApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Хранители Эфира',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        fontFamily: 'Roboto',
        textTheme: const TextTheme(
          bodyLarge: TextStyle(fontSize: 48, fontWeight: FontWeight.bold),
        ),
      ),
      home: const ParentGateScreen(),
    );
  }
}