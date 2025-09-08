import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/widgets/section_header.dart';
import 'section_card.dart';

class ProgressPhotoSection extends StatelessWidget {
  const ProgressPhotoSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SectionHeader(icon: Icons.photo_camera, title: 'Progress Photo (Optional)'),
        const SizedBox(height: 12),
        SectionCard(
          child: Container(
            height: 140,
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: AppColors.border, width: 1.2, strokeAlign: BorderSide.strokeAlignInside),
            ),
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.cloud_upload_outlined, color: AppColors.textSecondary, size: 32),
                  const SizedBox(height: 8),
                  Text('Upload a photo', style: AppTextStyles.h2.copyWith(color: AppColors.textPrimary)),
                  const SizedBox(height: 2),
                  Text('For tracking your progress', style: AppTextStyles.body2),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

