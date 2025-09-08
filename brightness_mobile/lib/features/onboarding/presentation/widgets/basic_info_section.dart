import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/widgets/section_header.dart';
import '../controllers/onboarding_controller.dart';
import 'section_card.dart';

class BasicInfoSection extends StatelessWidget {
  const BasicInfoSection({super.key});

  OutlineInputBorder _border(Color color) => OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: color, width: 1.2),
      );

  @override
  Widget build(BuildContext context) {
    final ctrl = context.read<OnboardingController>();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SectionHeader(icon: Icons.person, title: 'Basic Information'),
        const SizedBox(height: 12),
        SectionCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Full Name', style: AppTextStyles.h2),
              const SizedBox(height: 8),
              TextField(
                onChanged: ctrl.updateFullName,
                decoration: InputDecoration(
                  hintText: 'Enter your full name',
                  filled: true,
                  fillColor: AppColors.white,
                  contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
                  enabledBorder: _border(AppColors.border),
                  focusedBorder: _border(AppColors.primary),
                ),
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('Age', style: AppTextStyles.h2),
                        const SizedBox(height: 8),
                        TextField(
                          keyboardType: TextInputType.number,
                          onChanged: (v) {
                            final n = int.tryParse(v.trim());
                            if (n != null) ctrl.updateAge(n);
                          },
                          decoration: InputDecoration(
                            hintText: '25',
                            filled: true,
                            fillColor: AppColors.white,
                            contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
                            enabledBorder: _border(AppColors.border),
                            focusedBorder: _border(AppColors.primary),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('Gender', style: AppTextStyles.h2),
                        const SizedBox(height: 8),
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(color: AppColors.border, width: 1.2),
                          ),
                          padding: const EdgeInsets.symmetric(horizontal: 12),
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton<String>(
                              value: context.select((OnboardingController c) => c.gender),
                              borderRadius: BorderRadius.circular(12),
                              items: const [
                                DropdownMenuItem(value: 'Male', child: Text('Male')),
                                DropdownMenuItem(value: 'Female', child: Text('Female')),
                                DropdownMenuItem(value: 'Other', child: Text('Other')),
                              ],
                              onChanged: (v) {
                                if (v != null) ctrl.updateGender(v);
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('Height (cm)', style: AppTextStyles.h2),
                        const SizedBox(height: 8),
                        TextField(
                          keyboardType: const TextInputType.numberWithOptions(decimal: true),
                          onChanged: (v) {
                            final n = double.tryParse(v.trim());
                            if (n != null) ctrl.updateHeight(n);
                          },
                          decoration: InputDecoration(
                            hintText: '175',
                            filled: true,
                            fillColor: AppColors.white,
                            contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
                            enabledBorder: _border(AppColors.border),
                            focusedBorder: _border(AppColors.primary),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('Weight (kg)', style: AppTextStyles.h2),
                        const SizedBox(height: 8),
                        TextField(
                          keyboardType: const TextInputType.numberWithOptions(decimal: true),
                          onChanged: (v) {
                            final n = double.tryParse(v.trim());
                            if (n != null) ctrl.updateWeight(n);
                          },
                          decoration: InputDecoration(
                            hintText: '70',
                            filled: true,
                            fillColor: AppColors.white,
                            contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
                            enabledBorder: _border(AppColors.border),
                            focusedBorder: _border(AppColors.primary),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}

