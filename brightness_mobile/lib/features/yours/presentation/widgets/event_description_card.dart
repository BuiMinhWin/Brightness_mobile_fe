import 'package:flutter/material.dart';
import '../../data/models/event.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/theme/app_theme.dart';

class EventDescriptionCard extends StatelessWidget {
  final EventModel event;

  const EventDescriptionCard({
    super.key,
    required this.event,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(AppTheme.spacingL),
      decoration: AppTheme.cardDecoration(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: AppTheme.iconSizeL,
                height: AppTheme.iconSizeL,
                decoration: const BoxDecoration(
                  color: AppColors.primary, // dùng màu từ AppColors
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.info,
                  color: AppColors.white,
                  size: AppTheme.iconSizeS,
                ),
              ),
              const SizedBox(width: AppTheme.spacingM),
              Text(
                'Event Description',
                style: AppTextStyles.h2.copyWith(
                  color: AppColors.textPrimary,
                ),
              ),
            ],
          ),
          const SizedBox(height: AppTheme.spacingM),
          Text(
            event.fullDescription,
            style: AppTextStyles.body2.copyWith(
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }
}

class EventDurationCard extends StatelessWidget {
  final EventModel event;

  const EventDurationCard({
    super.key,
    required this.event,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(AppTheme.spacingL),
      decoration: AppTheme.cardDecoration(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: AppTheme.iconSizeL,
                height: AppTheme.iconSizeL,
                decoration: const BoxDecoration(
                  color: AppColors.secondary, // đổi từ hardcode sang secondary
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.calendar_today,
                  color: AppColors.white,
                  size: AppTheme.iconSizeS,
                ),
              ),
              const SizedBox(width: AppTheme.spacingM),
              Text(
                'Event Duration',
                style: AppTextStyles.h2.copyWith(
                  color: AppColors.textPrimary,
                ),
              ),
            ],
          ),
          const SizedBox(height: AppTheme.spacingXL),
          Row(
            children: [
              Expanded(
                child: Column(
                  children: [
                    Text(
                      '${event.durationDays}',
                      style: AppTextStyles.h1.copyWith(
                        color: AppColors.textPrimary,
                      ),
                    ),
                    Text(
                      'Days Total',
                      style: AppTextStyles.body2,
                    ),
                  ],
                ),
              ),
              Container(
                width: 1,
                height: 60,
                color: AppColors.border,
              ),
              Expanded(
                child: Column(
                  children: [
                    Text(
                      '${event.dailyMinutes}',
                      style: AppTextStyles.h1.copyWith(
                        color: AppColors.textPrimary,
                      ),
                    ),
                    Text(
                      'Min/Day',
                      style: AppTextStyles.body2,
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: AppTheme.spacingXL),
          _buildDateInfo('Start Date:', event.startDate),
          const SizedBox(height: AppTheme.spacingS),
          _buildDateInfo('End Date:', event.endDate),
        ],
      ),
    );
  }

  Widget _buildDateInfo(String label, String date) {
    return Row(
      children: [
        Text(
          label,
          style: AppTextStyles.body2,
        ),
        const SizedBox(width: AppTheme.spacingS),
        Text(
          date,
          style: AppTextStyles.bodyBold.copyWith(
            color: AppColors.textPrimary,
          ),
        ),
      ],
    );
  }
}
