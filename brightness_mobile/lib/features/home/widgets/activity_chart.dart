import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';

class ActivityChart extends StatelessWidget {
  final List<double> weeklyData;
  final double opacity;
  const ActivityChart({
    super.key,
    required this.weeklyData,
    this.opacity = 0.85,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.white.withOpacity(opacity.clamp(0.0, 1.0)),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(opacity.clamp(0.0, 1.0)),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        children: [
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: weeklyData.asMap().entries.map((entry) {
                final index = entry.key;
                final value = entry.value;
                final isToday = index == 3; // Today is 4th bar (0-indexed)
                final maxValue = weeklyData.reduce((a, b) => a > b ? a : b);
                final heightPercentage = value / maxValue;

                return Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                      width: 24,
                      height: (120 * heightPercentage).clamp(20, 120),
                      decoration: BoxDecoration(
                        color: isToday ? AppColors.primary : Colors.black,
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ],
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}
