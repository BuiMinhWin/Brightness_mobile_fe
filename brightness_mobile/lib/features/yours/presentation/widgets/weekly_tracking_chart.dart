import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/theme/app_theme.dart';

class WeeklyTrackingChart extends StatelessWidget {
  const WeeklyTrackingChart({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Sample data for weekly tracking
    final List<double> weeklyData = [2, 1, 5, 2, 3, 1, 4];
    final List<String> dayLabels = ['MON', 'TUE', 'WED', 'THU', 'FRI', 'SAT', 'SUN'];

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(AppTheme.spacingL),
      decoration: AppTheme.cardDecoration(),
      child: Column(
        children: [
          // Title
          Text(
            'TRACKING',
            style: AppTextStyles.h2.copyWith(
              fontSize: 16,
              color: AppColors.textSecondary,
              letterSpacing: 1.0,
            ),
          ),
          const SizedBox(height: AppTheme.spacingL),

          SizedBox(
            height: 200,
            child: Column(
              children: [
                // Y-axis + Bars
                Expanded(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      // Y-axis labels
                      SizedBox(
                        width: 30,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text('6', style: AppTextStyles.caption.copyWith(color: AppColors.textSecondary)),
                            Text('4', style: AppTextStyles.caption.copyWith(color: AppColors.textSecondary)),
                            Text('2', style: AppTextStyles.caption.copyWith(color: AppColors.textSecondary)),
                            Text('0', style: AppTextStyles.caption.copyWith(color: AppColors.textSecondary)),
                          ],
                        ),
                      ),

                      // Bars Section
                      Expanded(
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: List.generate(7, (index) {
                            return Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                // Bar
                                Container(
                                  width: 24,
                                  height: weeklyData[index] * 30, // Scale factor
                                  margin: const EdgeInsets.only(bottom: AppTheme.spacingM),
                                  decoration: BoxDecoration(
                                    color: index == 6
                                        ? AppColors.bright // Highlight today
                                        : AppColors.border,
                                    borderRadius: BorderRadius.circular(AppTheme.radiusS),
                                  ),
                                ),

                                // Day Labels
                                Text(
                                  dayLabels[index],
                                  style: AppTextStyles.caption.copyWith(
                                    fontSize: 10,
                                    color: AppColors.textSecondary,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            );
                          }),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
