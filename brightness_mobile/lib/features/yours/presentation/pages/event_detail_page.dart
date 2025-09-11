import 'package:brightness_mobile/features/yours/presentation/widgets/event_description_card.dart';
import 'package:brightness_mobile/features/yours/presentation/widgets/event_duration_card.dart' hide EventDurationCard;
import 'package:brightness_mobile/features/yours/presentation/widgets/how_to_participate_card.dart';
import 'package:flutter/material.dart';

import '../../data/models/event.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/theme/app_theme.dart';

class EventDetailPage extends StatelessWidget {
  final EventModel event;

  const EventDetailPage({
    Key? key,
    required this.event,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: AppColors.customGradient,
        ),
        child: SafeArea(
          child: Column(
            children: [
              _buildHeader(context),
              Expanded(
                child: _buildContent(),
              ),
              _buildActionButtons(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(AppTheme.spacingM),
      child: Row(
        children: [
          IconButton(
            onPressed: () {
              // Navigate back to event list
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.arrow_back,
              color: AppColors.white,
              size: AppTheme.iconSizeM,
            ),
          ),
          Expanded(
            child: Text(
              '${event.title} - Detail',
              style: AppTextStyles.h2.copyWith(
                color: AppColors.white,
                fontSize: AppTheme.fontSizeL,
                fontWeight: AppTheme.fontWeightSemiBold,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          SizedBox(width: AppTheme.iconSizeXL + AppTheme.spacingM),
        ],
      ),
    );
  }

  Widget _buildContent() {
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(horizontal: AppTheme.spacingM),
      child: Column(
        children: [
          EventDescriptionCard(event: event),
          SizedBox(height: AppTheme.spacingM),
          const HowToParticipateCard(),
          SizedBox(height: AppTheme.spacingM),
          EventDurationCard(event: event),
          SizedBox(height: AppTheme.spacingM),
          const RewardsAndPrizesCard(),
          SizedBox(height: AppTheme.spacingL),
        ],
      ),
    );
  }

  Widget _buildActionButtons(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(AppTheme.spacingL),
      child: Column(
        children: [
          Text(
            'Ready to start your ${event.title.toLowerCase()} journey?',
            style: AppTextStyles.body1.copyWith(
              color: AppColors.white,
              fontWeight: AppTheme.fontWeightMedium,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: AppTheme.spacingM),
          Row(
            children: [
              Expanded(
                child: _buildActionButton(
                  onPressed: () {
                    // Handle join event
                    _showJoinDialog(context);
                  },
                  icon: Icons.check,
                  color: AppColors.success,
                  tooltip: 'Join Event',
                ),
              ),
              SizedBox(width: AppTheme.spacingM),
              Expanded(
                child: _buildActionButton(
                  onPressed: () {
                    // Go back to events list
                    Navigator.pop(context);
                  },
                  icon: Icons.close,
                  color: AppColors.loseWeightColor,
                  tooltip: 'Go Back',
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildActionButton({
    required VoidCallback onPressed,
    required IconData icon,
    required Color color,
    required String tooltip,
  }) {
    return Tooltip(
      message: tooltip,
      child: Container(
        height: AppTheme.buttonHeightL,
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(AppTheme.buttonHeightL / 2),
          boxShadow: [
            BoxShadow(
              color: AppTheme.textPrimary.withValues(alpha: 0.1),
              blurRadius: 10,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: onPressed,
            borderRadius: BorderRadius.circular(AppTheme.buttonHeightL / 2),
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(color: color, width: 2),
                borderRadius: BorderRadius.circular(AppTheme.buttonHeightL / 2),
              ),
              child: Center(
                child: Icon(
                  icon,
                  color: color,
                  size: AppTheme.iconSizeL,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _showJoinDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: AppColors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppTheme.radiusXL),
          ),
          title: Text(
            'Join ${event.title}?',
            style: AppTextStyles.h2,
          ),
          content: Text(
            'Are you ready to commit to this ${event.durationDays}-day challenge?',
            style: AppTextStyles.body1,
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text(
                'Cancel',
                style: AppTextStyles.body1.copyWith(
                  color: AppColors.textSecondary,
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context); // Close dialog
                Navigator.pop(context); // Go back to events list
                // Here you would typically handle the join logic
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      'Successfully joined ${event.title}!',
                      style: AppTextStyles.body1.copyWith(
                        color: AppColors.white,
                      ),
                    ),
                    backgroundColor: AppColors.success,
                  ),
                );
              },
              style: AppTheme.primaryButtonStyle(
                backgroundColor: AppColors.success,
              ),
              child: Text(
                'Join Now',
                style: AppTextStyles.button,
              ),
            ),
          ],
        );
      },
    );
  }
}