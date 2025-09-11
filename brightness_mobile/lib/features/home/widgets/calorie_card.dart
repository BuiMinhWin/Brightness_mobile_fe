import 'package:flutter/material.dart';

import '../domain/entities/daily_stats.dart';

class CalorieCard extends StatelessWidget {
  final DailyStats dailyStats;

  const CalorieCard({super.key, required this.dailyStats});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(24),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Color(0xFF9FFFC8), Color(0xFF7AE582)],
          ),
          borderRadius: BorderRadius.circular(24),
        ),
        child: const SizedBox(height: 150),
      ),
    );
  }
}

// Removed FoxMascotPainter (replaced by asset image)
