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

                const double railHeight = 120;
                const double barWidth = 24;
                final double barHeight =
                    (railHeight * heightPercentage).clamp(20, railHeight).toDouble();

                return Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    // Stack a light rail behind with a shadowed foreground bar
                    Stack(
                      alignment: Alignment.bottomCenter,
                      children: [
                        // Background light rail
                        Container(
                          width: barWidth,
                          height: railHeight,
                          decoration: BoxDecoration(
                            color: const Color(0xFFE9EDF6), // light bluish grey
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        // Foreground bar with soft shadow
                        Container(
                          width: barWidth,
                          height: barHeight,
                          decoration: BoxDecoration(
                            color: isToday ? AppColors.primary : Colors.black,
                            borderRadius: BorderRadius.circular(12),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.25),
                                blurRadius: 6,
                                spreadRadius: 0,
                                offset: const Offset(0, 3),
                              ),
                            ],
                          ),
                        ),
                      ],
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
