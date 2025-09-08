import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/widgets/section_header.dart';
import '../controllers/onboarding_controller.dart';
import 'section_card.dart';

class FitnessGoalsSection extends StatelessWidget {
  const FitnessGoalsSection({super.key});

  Widget _goalItem({
    required BuildContext context,
    required String value,
    required IconData icon,
    required String title,
    required String subtitle,
  }) {
    final selected = context.select((OnboardingController c) => c.fitnessGoal) == value;
    return InkWell(
      onTap: () => context.read<OnboardingController>().updateFitnessGoal(value),
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: selected ? AppColors.primary : AppColors.border, width: 1.2),
        ),
        child: Row(
          children: [
            Icon(icon, color: selected ? AppColors.primary : AppColors.textSecondary),
            const SizedBox(width: 12),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: AppTextStyles.h2),
                const SizedBox(height: 4),
                Text(subtitle, style: AppTextStyles.body2),
              ],
            )
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SectionHeader(icon: Icons.adjust, title: 'Fitness Goals'),
        const SizedBox(height: 12),
        SectionCard(
          padding: const EdgeInsets.all(12),
          child: Column(
            children: [
              _goalItem(
                context: context,
                value: 'Lose Weight',
                icon: Icons.local_fire_department,
                title: 'Lose Weight',
                subtitle: 'Burn fat and get lean',
              ),
              const SizedBox(height: 12),
              _goalItem(
                context: context,
                value: 'Gain Muscle',
                icon: Icons.fitness_center,
                title: 'Gain Muscle',
                subtitle: 'Build strength and mass',
              ),
              const SizedBox(height: 12),
              _goalItem(
                context: context,
                value: 'Maintain Health',
                icon: Icons.favorite,
                title: 'Maintain Health',
                subtitle: 'Stay fit and healthy',
              ),
            ],
          ),
        ),
      ],
    );
  }
}

