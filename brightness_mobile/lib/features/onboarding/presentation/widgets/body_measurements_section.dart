import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/widgets/section_header.dart';
import '../controllers/onboarding_controller.dart';
import 'section_card.dart';

class BodyMeasurementsSection extends StatelessWidget {
  const BodyMeasurementsSection({super.key});

  OutlineInputBorder _border(Color c) => OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: c, width: 1.2),
      );

  Widget _field({required String label, required String hint, required ValueChanged<double?> onChanged}) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: AppTextStyles.h2),
          const SizedBox(height: 8),
          TextField(
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            onChanged: (v) => onChanged(double.tryParse(v.trim())),
            decoration: InputDecoration(
              hintText: hint,
              filled: true,
              fillColor: AppColors.white,
              contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
              enabledBorder: _border(AppColors.border),
              focusedBorder: _border(AppColors.primary),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final ctrl = context.read<OnboardingController>();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SectionHeader(icon: Icons.straighten, title: 'Body Measurements (Optional)'),
        const SizedBox(height: 12),
        SectionCard(
          child: Column(
            children: [
              Row(
                children: [
                  _field(label: 'Waist (cm)', hint: '80', onChanged: ctrl.updateWaist),
                  const SizedBox(width: 12),
                  _field(label: 'Chest (cm)', hint: '95', onChanged: ctrl.updateChest),
                  const SizedBox(width: 12),
                  _field(label: 'Hips (cm)', hint: '90', onChanged: ctrl.updateHips),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}

