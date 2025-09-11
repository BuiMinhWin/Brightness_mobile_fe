import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';

class ChallengeRulesSection extends StatelessWidget {
  const ChallengeRulesSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.warningLight,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: AppColors.warning,
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(
                Icons.warning_amber,
                color: AppColors.redDark,
                size: 16,
              ),
              const SizedBox(width: 8),
              Text(
                'Challenge Rules',
                style: AppTextStyles.captionBold.copyWith(
                  color: AppColors.redDark,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          _buildRuleItem('No skipping more than 5 consecutive days'),
          _buildRuleItem('Must complete minimum 80% of each workout'),
          _buildRuleItem('Progress photos required weekly for verification'),
          _buildRuleItem('Follow community guidelines and support others'),
        ],
      ),
    );
  }

  Widget _buildRuleItem(String rule) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 4,
            height: 4,
            margin: const EdgeInsets.only(top: 6),
            decoration: const BoxDecoration(
              color: AppColors.redDark,
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              rule,
              style: AppTextStyles.caption.copyWith(
                color: AppColors.redDark,
                height: 1.4,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
