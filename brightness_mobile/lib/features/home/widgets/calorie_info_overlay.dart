import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../domain/entities/daily_stats.dart';
import 'package:brightness_mobile/app/router.dart';

class CalorieInfoOverlay extends StatelessWidget {
  final DailyStats dailyStats;
  const CalorieInfoOverlay({super.key, required this.dailyStats});

  String _monthAbbrev(int m) => const [
    'Jan',
    'Feb',
    'Mar',
    'Apr',
    'May',
    'Jun',
    'Jul',
    'Aug',
    'Sep',
    'Oct',
    'Nov',
    'Dec',
  ][m - 1];

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();
    final darkTeal = AppColors.tealDark;
    final kcalFormatter = NumberFormat.decimalPattern('fr_FR');

    return IgnorePointer(
      ignoring: false,
      child: Stack(
        children: [
          // Big circle on the left touching the card's inner edge
          Positioned(
            left: -50,
            top: 0,
            child: Container(
              width: 260,
              height: 250,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: darkTeal.withOpacity(0.78),
              ),
            ),
          ),

          // Texts and Calendar button
          Padding(
            padding: const EdgeInsets.fromLTRB(14, 20, 130, 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Dòng 1: Today, 8 Jul - dịch sang phải
                Padding(
                  padding: const EdgeInsets.only(left: 30),
                  child: Text(
                    "Today, ${now.day} ${_monthAbbrev(now.month)}",
                    style: AppTextStyles.body2.copyWith(
                      color: darkTeal.withOpacity(0.9),
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                // Dòng 2: Kcal
                Text(
                  "${kcalFormatter.format(dailyStats.calories.toInt())} Kcal",
                  style: TextStyle(
                    fontSize: 36,
                    fontWeight: FontWeight.w900,
                    color: darkTeal,
                    letterSpacing: -0.5,
                  ),
                ),
                const SizedBox(height: 0),
                // Dòng 3: Calendar button - dịch sang phải
                Padding(
                  padding: const EdgeInsets.only(left: 30),
                  child: GestureDetector(
                    onTap: () =>
                        Navigator.of(context).pushNamed(AppRouter.calendar),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 8,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.white,
                        borderRadius: BorderRadius.circular(15),
                        boxShadow: const [
                          BoxShadow(
                            color: AppColors.shadow,
                            blurRadius: 4,
                            offset: Offset(0, 1),
                          ),
                        ],
                      ),
                      child: Text(
                        "Calendar",
                        style: TextStyle(
                          color: darkTeal,
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
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
