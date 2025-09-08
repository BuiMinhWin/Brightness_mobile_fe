import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../domain/entities/fitness_program.dart';

class FitnessProgramsSection extends StatelessWidget {
  final List<FitnessProgram> programs;

  const FitnessProgramsSection({super.key, required this.programs});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Recent Plan", style: AppTextStyles.h2),
                Text(
                  "July, 2021",
                  style: AppTextStyles.body2.copyWith(
                    color: AppColors.textSecondary,
                  ),
                ),
              ],
            ),
            Text(
              "See All",
              style: AppTextStyles.body1.copyWith(
                color: AppColors.primary,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),

        const SizedBox(height: 16),

        SizedBox(
          height: 120,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: programs.length,
            itemBuilder: (context, index) {
              final program = programs[index];
              return Container(
                width: 100,
                margin: EdgeInsets.only(
                  left: index == 0 ? 0 : 12,
                  right: index == programs.length - 1 ? 0 : 0,
                ),
                child: Column(
                  children: [
                    Container(
                      width: 80,
                      height: 80,
                      decoration: BoxDecoration(
                        color: _getProgramColor(program.color),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Icon(
                        _getProgramIcon(program.type),
                        color: AppColors.white,
                        size: 32,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      program.title,
                      style: AppTextStyles.body2.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                      textAlign: TextAlign.center,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Color _getProgramColor(String color) {
    switch (color) {
      case 'green':
        return const Color(0xFF10B981);
      case 'blue':
        return const Color(0xFF3B82F6);
      case 'teal':
        return const Color(0xFF06B6D4);
      case 'purple':
        return const Color(0xFF8B5CF6);
      default:
        return AppColors.primary;
    }
  }

  IconData _getProgramIcon(String type) {
    switch (type) {
      case 'special':
        return Icons.star;
      case 'beach':
        return Icons.waves;
      case 'fullbody':
        return Icons.fitness_center;
      case 'challenge':
        return Icons.emoji_events;
      default:
        return Icons.fitness_center;
    }
  }
}
