import 'package:brightness_mobile/features/yours/data/models/yours.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import 'package:flutter/material.dart';

class EventTrackingDescriptionCard extends StatelessWidget {
  final DietPlanModel dietPlan;

  const EventTrackingDescriptionCard({
    super.key,
    required this.dietPlan,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: AppColors.black.withAlpha(26),
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
                  color: AppColors.primaryBlue,
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.info,
                  color: AppColors.white,
                  size: 16,
                ),
              ),
              const SizedBox(width: 12),
              Text(
                'Event Description',
                style: AppTextStyles.headingMedium.copyWith(
                  color: AppColors.textPrimary,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Text(
            'Join thousands of fitness enthusiasts in our most exciting 30-day challenge yet! This comprehensive program combines strength training, cardio workouts, and mindfulness practices to help you achieve your fitness goals. Whether you\'re a beginner or an experienced athlete, this challenge adapts to your fitness level and pushes you to new heights.',
            style: AppTextStyles.bodySmall.copyWith(
              color: AppColors.textSecondary,
              height: 1.5,
            ),
          ),
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: AppColors.greenlight,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.trending_up,
                  color: dietPlan.progressColor,
                  size: 20,
                ),
                const SizedBox(width: 8),
                Text(
                  'Current Progress: ${dietPlan.progressPercentage}',
                  style: AppTextStyles.bodySmall.copyWith(
                    fontWeight: FontWeight.w600,
                    color: dietPlan.progressColor,
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
