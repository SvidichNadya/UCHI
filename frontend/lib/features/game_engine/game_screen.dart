import 'package:flutter/material.dart';
import 'package:ether_guardians/core/theme/app_theme.dart';

class GameScreen extends StatelessWidget {
  const GameScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black, // Игровой фон
      body: Stack(
        children:,
                        ),
                      ),
                    ],
                  ),
                  
                  const Spacer(),
                  
                  // Внутриигровой диалог (Компаньон)
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      constraints: const BoxConstraints(maxWidth: 800), // Сетка центрирования
                      padding: const EdgeInsets.all(AppTheme.m6),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.95),
                        borderRadius: AppTheme.radiusBlock, // 32px
                        boxShadow: AppTheme.baseShadow,
                      ),
                      child: Row(
                        children:,
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