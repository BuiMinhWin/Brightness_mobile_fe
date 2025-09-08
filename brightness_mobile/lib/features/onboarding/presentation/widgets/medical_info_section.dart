import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/widgets/section_header.dart';
import '../controllers/onboarding_controller.dart';
import 'section_card.dart';

class MedicalInfoSection extends StatelessWidget {
  const MedicalInfoSection({super.key});

  OutlineInputBorder _border(Color c) => OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: c, width: 1.2),
      );

  @override
  Widget build(BuildContext context) {
    final ctrl = context.read<OnboardingController>();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SectionHeader(icon: Icons.health_and_safety, title: 'Medical Information'),
        const SizedBox(height: 12),
        SectionCard(
          child: TextField(
            maxLines: 5,
            onChanged: ctrl.updateMedicalInfo,
            decoration: InputDecoration(
              hintText: 'Any medical conditions, injuries, or limitations we should know about? (Optional)',
              hintStyle: AppTextStyles.body2,
              filled: true,
              fillColor: AppColors.white,
              contentPadding: const EdgeInsets.all(14),
              enabledBorder: _border(AppColors.border),
              focusedBorder: _border(AppColors.primary),
            ),
          ),
        ),
      ],
    );
  }
}

