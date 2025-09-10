import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
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
            colors: [Color(0xFF4AE5C3), Color(0xFF7AE582)],
          ),
          borderRadius: BorderRadius.circular(24),
        ),
        child: Stack(
          children: [
            // Ensure Stack is tall enough so mascot isn't clipped
            const SizedBox(height: 190),
            Padding(
              padding: const EdgeInsets.only(right: 130, top: 100),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Today, 8 Jul",
                    style: AppTextStyles.body2.copyWith(
                      color: AppColors.white.withOpacity(0.8),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    "${dailyStats.calories.toInt()} Kcal",
                    style: const TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: AppColors.white,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 8,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.white.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: const Text(
                      "Calendar",
                      style: TextStyle(
                        color: AppColors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Removed FoxMascotPainter (replaced by asset image)
