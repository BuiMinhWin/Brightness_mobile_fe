import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../domain/entities/daily_stats.dart';

class StatsOverview extends StatelessWidget {
  final DailyStats dailyStats;
  final double opacity;

  const StatsOverview({
    super.key,
    required this.dailyStats,
    this.opacity = 0.85,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: AppColors.white.withAlpha((255 * opacity.clamp(0.0, 1.0)).round()),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: AppColors.white.withAlpha((255 * opacity.clamp(0.0, 1.0)).round()),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        children: [
          // Main calorie display
          Text(
            "${dailyStats.calories.toInt()} Kcal",
            style: const TextStyle(
              fontSize: 36,
              fontWeight: FontWeight.bold,
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            "Total Kilocalories",
            style: AppTextStyles.body2.copyWith(color: AppColors.textSecondary),
          ),

          const SizedBox(height: 24),

          // Stats row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildStatItem("${(dailyStats.distance).toInt()} m", "Distance"),
              _buildStatItem("${dailyStats.steps}", "Steps"),
              _buildStatItem("${dailyStats.points}", "Points"),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatItem(String value, String label) {
    return Column(
      children: [
        Text(
          value,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: AppColors.textPrimary,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: AppTextStyles.body2.copyWith(color: AppColors.textSecondary),
        ),
      ],
    );
  }
}
