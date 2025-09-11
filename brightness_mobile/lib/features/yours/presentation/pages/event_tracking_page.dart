import 'package:brightness_mobile/features/yours/data/models/task.dart';
import 'package:brightness_mobile/features/yours/presentation/widgets/additional_tasks_card.dart';
import 'package:brightness_mobile/features/yours/presentation/widgets/completed_challenges_card.dart';
import 'package:brightness_mobile/features/yours/presentation/widgets/event_tracking_description_card.dart';
import 'package:brightness_mobile/features/yours/presentation/widgets/ongoing_challenges_card.dart';
import 'package:brightness_mobile/features/yours/presentation/widgets/weekly_tracking_chart.dart';
import 'package:flutter/material.dart';

import '../../data/models/yours.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/theme/app_theme.dart';

class EventTrackingPage extends StatelessWidget {
  final DietPlanModel dietPlan;

  const EventTrackingPage({
    super.key,
    required this.dietPlan,
  });

  @override
  Widget build(BuildContext context) {
    // Sample task data based on your database schema
    final List<TaskModel> ongoingTasks = [
      TaskModel(
        id: '1',
        participantId: 'user123',
        taskId: '001',
        targetDate: DateTime.now().add(const Duration(days: 2)),
        status: 'ongoing',
        point: 10,
      ),
      TaskModel(
        id: '2',
        participantId: 'user123',
        taskId: '002',
        targetDate: DateTime.now().add(const Duration(days: 1)),
        status: 'in_progress',
        point: 15,
      ),
    ];

    final List<TaskModel> completedTasks = List.generate(20, (index) {
      return TaskModel(
        id: 'completed_${index + 1}',
        participantId: 'user123',
        taskId: '${100 + index}',
        targetDate: DateTime.now().subtract(Duration(days: index + 1)),
        status: 'completed',
        point: 10 + (index % 3) * 5,
        completedAt: DateTime.now().subtract(Duration(days: index)),
      );
    });

    final List<TaskModel> additionalTasks = List.generate(5, (index) {
      return TaskModel(
        id: 'additional_${index + 1}',
        participantId: 'user123',
        taskId: '${200 + index}',
        targetDate: DateTime.now().add(Duration(days: index + 3)),
        status: 'pending',
        point: 5,
      );
    });

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
                child: _buildContent(ongoingTasks, completedTasks, additionalTasks),
              ),
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
            onPressed: () => Navigator.pop(context),
            icon: Icon(
              Icons.arrow_back,
              color: AppColors.white,
              size: AppTheme.iconSizeM,
            ),
          ),
          Expanded(
            child: Text(
              'Tracking Event',
              style: AppTextStyles.h2.copyWith(
                color: AppColors.white,
                fontSize: AppTheme.fontSizeXL,
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

  Widget _buildContent(List<TaskModel> ongoingTasks, List<TaskModel> completedTasks, List<TaskModel> additionalTasks) {
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(horizontal: AppTheme.spacingM),
      child: Column(
        children: [
          EventTrackingDescriptionCard(dietPlan: dietPlan),
          SizedBox(height: AppTheme.spacingM),
          const WeeklyTrackingChart(),
          SizedBox(height: AppTheme.spacingM),
          OngoingChallengesCard(ongoingTasks: ongoingTasks),
          SizedBox(height: AppTheme.spacingM),
          CompletedChallengesCard(completedTasks: completedTasks),
          SizedBox(height: AppTheme.spacingM),
          AdditionalTasksCard(additionalTasks: additionalTasks),
          SizedBox(height: AppTheme.spacingL),
        ],
      ),
    );
  }
}