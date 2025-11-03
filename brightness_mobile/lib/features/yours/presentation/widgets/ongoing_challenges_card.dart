import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/theme/app_theme.dart';
import 'package:brightness_mobile/features/yours/data/models/task.dart';
import 'package:flutter/material.dart';

class OngoingChallengesCard extends StatefulWidget {
  final List<TaskModel> ongoingTasks;

  const OngoingChallengesCard({
    super.key,
    this.ongoingTasks = const [],
  });

  @override
  State<OngoingChallengesCard> createState() => _OngoingChallengesCardState();
}

class _OngoingChallengesCardState extends State<OngoingChallengesCard> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Header
        Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(
            horizontal: AppTheme.spacingL,
            vertical: AppTheme.spacingS,
          ),
          decoration: BoxDecoration(
            color: AppColors.success,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(AppTheme.radiusM),
              topRight: Radius.circular(AppTheme.radiusM),
            ),
          ),
          child: Text(
            'ONGOING',
            style: AppTextStyles.bodyBold.copyWith(
              color: AppColors.white,
              letterSpacing: 1.0,
            ),
          ),
        ),

        // Content
        Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(AppTheme.radiusM),
              bottomRight: Radius.circular(AppTheme.radiusM),
            ),
            boxShadow: [
              BoxShadow(
                color: AppColors.shadow,
                blurRadius: 10,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Column(
            children: [
              InkWell(
                onTap: () => setState(() => _isExpanded = !_isExpanded),
                child: Padding(
                  padding: const EdgeInsets.all(AppTheme.spacingL),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('CHALLENGES', style: AppTextStyles.h2),
                      Row(
                        children: [
                          Text('${widget.ongoingTasks.length}',
                              style: AppTextStyles.h2),
                          const SizedBox(width: AppTheme.spacingS),
                          AnimatedRotation(
                            duration: const Duration(milliseconds: 200),
                            turns: _isExpanded ? 0.5 : 0,
                            child: Icon(
                              Icons.keyboard_arrow_down,
                              color: AppColors.textSecondary,
                              size: 20,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                height: _isExpanded ? null : 0,
                child: _isExpanded ? _buildTaskList() : null,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildTaskList() {
    if (widget.ongoingTasks.isEmpty) {
      return Padding(
        padding: const EdgeInsets.all(AppTheme.spacingL),
        child: Container(
          padding: const EdgeInsets.all(AppTheme.spacingM),
          decoration: BoxDecoration(
            color: AppColors.backgroundLight,
            borderRadius: BorderRadius.circular(AppTheme.radiusS),
          ),
          child: Row(
            children: [
              Icon(Icons.info_outline,
                  color: AppColors.iconInactive, size: 20),
              const SizedBox(width: AppTheme.spacingM),
              Text(
                'No ongoing challenges',
                style: AppTextStyles.body
                    .copyWith(color: AppColors.textSecondary),
              ),
            ],
          ),
        ),
      );
    }

    return Padding(
      padding: const EdgeInsets.all(AppTheme.spacingL),
      child: Column(
        children:
            widget.ongoingTasks.map((task) => _buildTaskItem(task)).toList(),
      ),
    );
  }

  Widget _buildTaskItem(TaskModel task) {
    return Container(
      margin: const EdgeInsets.only(bottom: AppTheme.spacingM),
      padding: const EdgeInsets.all(AppTheme.spacingM),
      decoration: BoxDecoration(
        color: AppColors.greenlight,
        borderRadius: BorderRadius.circular(AppTheme.radiusS),
        border: Border.all(
          color: AppColors.success.withAlpha(51),
          width: 1,
        ),
      ),
      child: Row(
        children: [
          Container(
            width: 8,
            height: 8,
            decoration: const BoxDecoration(
              color: AppColors.success,
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(width: AppTheme.spacingM),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Task #${task.taskId}', style: AppTextStyles.bodyBold),
                const SizedBox(height: 4),
                Text(
                  'Due: ${_formatDate(task.targetDate)}',
                  style: AppTextStyles.caption
                      .copyWith(color: AppColors.textSecondary),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: AppTheme.spacingS,
              vertical: 4,
            ),
            decoration: BoxDecoration(
              color: AppColors.success,
              borderRadius: BorderRadius.circular(AppTheme.radiusS),
            ),
            child: Text(
              '${task.point}pt',
              style: AppTextStyles.captionBold.copyWith(color: AppColors.white),
            ),
          ),
        ],
      ),
    );
  }

  String _formatDate(DateTime date) => '${date.day}/${date.month}/${date.year}';
}
