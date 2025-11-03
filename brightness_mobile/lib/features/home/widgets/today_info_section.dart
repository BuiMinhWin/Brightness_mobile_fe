import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../domain/entities/daily_stats.dart';

class TodayInfoSection extends StatelessWidget {
  final DailyStats dailyStats;

  const TodayInfoSection({super.key, required this.dailyStats});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Today's Information", style: AppTextStyles.h2),
            Text(
              "July, 2021",
              style: AppTextStyles.body2.copyWith(
                color: AppColors.textSecondary,
              ),
            ),
          ],
        ),

        const SizedBox(height: 16),

        _buildInfoCard(
          "Calories",
          "620.68",
          "Kcal",
          const Color(0xFF10B981),
          Icons.local_fire_department,
        ),

        const SizedBox(height: 12),

        _buildInfoCard(
          "Steps",
          "1240",
          "Steps",
          const Color(0xFF06B6D4),
          Icons.directions_walk,
        ),
      ],
    );
  }

  Widget _buildInfoCard(
    String title,
    String value,
    String unit,
    Color color,
    IconData icon,
  ) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(13),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: color.withAlpha(26),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: color, size: 20),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: AppTextStyles.body2.copyWith(
                    color: AppColors.textSecondary,
                  ),
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    Text(value, style: AppTextStyles.h2.copyWith(fontSize: 20)),
                    const SizedBox(width: 4),
                    Text(
                      unit,
                      style: AppTextStyles.body2.copyWith(
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
