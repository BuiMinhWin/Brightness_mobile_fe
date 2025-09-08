import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/widgets/section_header.dart';
import '../controllers/onboarding_controller.dart';
import 'section_card.dart';

class ActivityLevelSection extends StatelessWidget {
  const ActivityLevelSection({super.key});

  Widget _levelItem(BuildContext context, String value, IconData icon) {
    final selected = context.select((OnboardingController c) => c.activityLevel) == value;
    return Expanded(
      child: InkWell(
        onTap: () => context.read<OnboardingController>().updateActivityLevel(value),
        child: Container(
          height: 72,
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: selected ? AppColors.primary : AppColors.border, width: 1.2),
          ),
          child: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(icon, color: selected ? AppColors.primary : AppColors.textSecondary),
                const SizedBox(width: 8),
                Text(value, style: AppTextStyles.body1),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SectionHeader(icon: Icons.show_chart, title: 'Activity Level'),
        const SizedBox(height: 12),
        SectionCard(
          padding: const EdgeInsets.all(12),
          child: Column(
            children: [
              Row(
                children: [
                  _levelItem(context, 'Sedentary', Icons.chair_alt),
                  const SizedBox(width: 12),
                  _levelItem(context, 'Lightly Active', Icons.directions_walk),
                ],
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  _levelItem(context, 'Active', Icons.directions_run),
                  const SizedBox(width: 12),
                  _levelItem(context, 'Very Active', Icons.local_fire_department),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}

