import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/theme/app_theme.dart';

class EventDurationCard extends StatelessWidget {
  const EventDurationCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(AppTheme.spacingL),
      decoration: AppTheme.cardDecoration(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 24,
                height: 24,
                decoration: const BoxDecoration(
                  color: AppColors.secondary, // dùng màu từ AppColors
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.calendar_today,
                  color: AppColors.white,
                  size: AppTheme.iconSizeS,
                ),
              ),
              const SizedBox(width: AppTheme.spacingM),
              Text(
                'Event Duration',
                style: AppTextStyles.h2, // dùng text style có sẵn
              ),
            ],
          ),
          const SizedBox(height: AppTheme.spacingXL),
          Row(
            children: [
              Expanded(
                child: Column(
                  children: [
                    Text(
                      '30',
                      style: AppTheme.textStyleHeadline2.copyWith(
                        color: AppColors.textPrimary,
                      ),
                    ),
                    Text(
                      'Days Total',
                      style: AppTheme.textStyleBody2,
                    ),
                  ],
                ),
              ),
              Container(
                width: 1,
                height: 60,
                color: AppColors.border,
              ),
              Expanded(
                child: Column(
                  children: [
                    Text(
                      '45',
                      style: AppTheme.textStyleHeadline2.copyWith(
                        color: AppColors.textPrimary,
                      ),
                    ),
                    Text(
                      'Min/Day',
                      style: AppTheme.textStyleBody2,
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: AppTheme.spacingXL),
          _buildDateInfo('Start Date:', 'March 1, 2024'),
          const SizedBox(height: AppTheme.spacingS),
          _buildDateInfo('End Date:', 'March 30, 2024'),
        ],
      ),
    );
  }

  Widget _buildDateInfo(String label, String date) {
    return Row(
      children: [
        Text(
          label,
          style: AppTheme.textStyleBody2.copyWith(
            fontWeight: AppTheme.fontWeightMedium,
          ),
        ),
        const SizedBox(width: AppTheme.spacingS),
        Text(
          date,
          style: AppTextStyles.bodyBold,
        ),
      ],
    );
  }
}

// Rewards & Prizes card
class RewardsAndPrizesCard extends StatelessWidget {
  const RewardsAndPrizesCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(AppTheme.spacingL),
      decoration: AppTheme.cardDecoration(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 24,
                height: 24,
                decoration: const BoxDecoration(
                  color: AppColors.warning,
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.emoji_events,
                  color: AppColors.white,
                  size: AppTheme.iconSizeS,
                ),
              ),
              const SizedBox(width: AppTheme.spacingM),
              Text(
                'Rewards & Prizes',
                style: AppTextStyles.h2,
              ),
            ],
          ),
          const SizedBox(height: AppTheme.spacingL),
          _buildPrizeItem(
            Icons.emoji_events,
            'Grand Prize Winner',
            '\$300 in cash',
            AppColors.bright,
            AppColors.warningLight,
          ),
          const SizedBox(height: AppTheme.spacingM),
          _buildPrizeItem(
            Icons.military_tech,
            'Top 10 Finishers',
            'Premium workout gear',
            AppColors.loseWeightColor,
            AppColors.warningLight,
          ),
          const SizedBox(height: AppTheme.spacingM),
          _buildPrizeItem(
            Icons.stars,
            'All Completers',
            'Digital badge & certificate',
            AppColors.gainMuscleColor,
            AppColors.backgroundLight,
          ),
        ],
      ),
    );
  }

  Widget _buildPrizeItem(
    IconData icon,
    String title,
    String description,
    Color iconColor,
    Color bgColor,
  ) {
    return Container(
      padding: const EdgeInsets.all(AppTheme.spacingM),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(AppTheme.radiusM),
        border: Border.all(
          color: iconColor.withOpacity(0.3),
          width: 1,
        ),
      ),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: iconColor,
              borderRadius: BorderRadius.circular(AppTheme.radiusM),
            ),
            child: Icon(
              icon,
              color: AppColors.white,
              size: AppTheme.iconSizeM,
            ),
          ),
          const SizedBox(width: AppTheme.spacingM),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: AppTextStyles.h3),
                const SizedBox(height: AppTheme.spacingXS),
                Text(description, style: AppTheme.textStyleBody2),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
