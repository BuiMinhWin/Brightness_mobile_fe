import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/widgets/section_header.dart';
import '../controllers/onboarding_controller.dart';
import 'section_card.dart';

class WorkoutScheduleSection extends StatelessWidget {
  const WorkoutScheduleSection({super.key});

  static const _days = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SectionHeader(icon: Icons.calendar_month, title: 'Workout Schedule'),
        const SizedBox(height: 12),
        SectionCard(
          padding: const EdgeInsets.all(12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: _days.map((day) {
              final selected = context.select((OnboardingController c) => c.workoutDays.contains(day));
              return Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4),
                  child: InkWell(
                    onTap: () => context.read<OnboardingController>().toggleWorkoutDay(day),
                    child: Container(
                      height: 48,
                      decoration: BoxDecoration(
                        color: selected ? AppColors.primary : AppColors.white,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: selected ? AppColors.primary : AppColors.border, width: 1.2),
                      ),
                      child: Center(
                        child: Text(
                          day,
                          style: AppTextStyles.body1.copyWith(
                            color: selected ? AppColors.white : AppColors.textPrimary,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }
}
