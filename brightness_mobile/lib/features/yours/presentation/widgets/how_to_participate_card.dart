import 'dart:ui';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/theme/app_theme.dart';
import 'package:brightness_mobile/features/yours/presentation/widgets/challenge_rules_section.dart';
import 'package:flutter/material.dart';

class HowToParticipateCard extends StatelessWidget {
  const HowToParticipateCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(AppTheme.radiusL),
        boxShadow: [
          BoxShadow(
            color: AppColors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 24,
                height: 24,
                decoration: const BoxDecoration(
                  color: AppColors.success,
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.lock_open,
                  color: AppColors.white,
                  size: AppTheme.iconSizeS,
                ),
              ),
              const SizedBox(width: 12),
              Text(
                'How to Participate',
                style: AppTextStyles.headingMedium,
              ),
            ],
          ),
          const SizedBox(height: 20),
          _buildParticipationStep(
            '1',
            'Complete Daily Workouts',
            'Follow the daily workout routine\n(30-45 minutes each day)',
          ),
          const SizedBox(height: 16),
          _buildParticipationStep(
            '2',
            'Track Your Progress',
            'Log your workouts, upload progress photos weekly',
          ),
          const SizedBox(height: 16),
          _buildParticipationStep(
            '3',
            'Stay Consistent',
            'Complete at least 25 out of 30 days.',
          ),
          const SizedBox(height: 20),
          const ChallengeRulesSection(),
        ],
      ),
    );
  }

  Widget _buildParticipationStep(
      String number, String title, String description) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 24,
          height: 24,
          decoration: BoxDecoration(
            color: AppColors.primaryBlue,
            borderRadius: BorderRadius.circular(AppTheme.radiusS),
          ),
          child: Center(
            child: Text(
              number,
              style: AppTextStyles.captionBold.copyWith(
                color: AppColors.white,
              ),
            ),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: AppTextStyles.bodyBold,
              ),
              const SizedBox(height: 4),
              Text(
                description,
                style: AppTextStyles.bodySmall.copyWith(height: 1.4),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
