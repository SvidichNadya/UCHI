import 'package:flutter/material.dart';
import 'game_world.dart';
import 'package:flame/game.dart';

class EtherWorldWidget extends StatelessWidget {
  const EtherWorldWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GameWidget(game: EtherWorld()),
    );
  }
}