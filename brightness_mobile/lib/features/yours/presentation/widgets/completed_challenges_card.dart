import 'package:brightness_mobile/core/theme/app_colors.dart';
import 'package:brightness_mobile/core/theme/app_text_styles.dart';
import 'package:brightness_mobile/core/theme/app_theme.dart';
import 'package:brightness_mobile/features/yours/data/models/task.dart';
import 'package:flutter/material.dart';

class CompletedChallengesCard extends StatefulWidget {
  final List<TaskModel> completedTasks;

  const CompletedChallengesCard({
    Key? key,
    this.completedTasks = const [],
  }) : super(key: key);

  @override
  State<CompletedChallengesCard> createState() => _CompletedChallengesCardState();
}

class _CompletedChallengesCardState extends State<CompletedChallengesCard> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: AppTheme.spacingL, vertical: AppTheme.spacingS),
          decoration: BoxDecoration(
            color: AppColors.warning,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(AppTheme.radiusM),
              topRight: Radius.circular(AppTheme.radiusM),
            ),
          ),
          child: Text(
            'COMPLETED',
            style: AppTextStyles.bodyBold.copyWith(
              color: AppColors.white,
              letterSpacing: 1.0,
            ),
          ),
        ),
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
                          Text(
                            '${widget.completedTasks.length}',
                            style: AppTextStyles.h2,
                          ),
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
    if (widget.completedTasks.isEmpty) {
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
              Icon(Icons.check_circle_outline, color: AppColors.iconInactive, size: 20),
              const SizedBox(width: AppTheme.spacingM),
              Text('No completed challenges yet', style: AppTextStyles.body.copyWith(color: AppColors.textSecondary)),
            ],
          ),
        ),
      );
    }

    return Padding(
      padding: const EdgeInsets.all(AppTheme.spacingL),
      child: Column(
        children: widget.completedTasks.map((task) => _buildTaskItem(task)).toList(),
      ),
    );
  }

  Widget _buildTaskItem(TaskModel task) {
    return Container(
      margin: const EdgeInsets.only(bottom: AppTheme.spacingM),
      padding: const EdgeInsets.all(AppTheme.spacingM),
      decoration: BoxDecoration(
        color: AppColors.warningLight,
        borderRadius: BorderRadius.circular(AppTheme.radiusS),
        border: Border.all(color: AppColors.warning.withOpacity(0.3), width: 1),
      ),
      child: Row(
        children: [
          Icon(Icons.check_circle, color: AppColors.success, size: 20),
          const SizedBox(width: AppTheme.spacingM),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Task #${task.taskId}', style: AppTextStyles.bodyBold),
                const SizedBox(height: 4),
                Text(
                  'Completed: ${task.completedAt != null ? _formatDate(task.completedAt!) : 'Unknown'}',
                  style: AppTextStyles.caption.copyWith(color: AppColors.textSecondary),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: AppTheme.spacingS, vertical: 4),
            decoration: BoxDecoration(
              color: AppColors.success,
              borderRadius: BorderRadius.circular(AppTheme.radiusS),
            ),
            child: Text('+${task.point}pt', style: AppTextStyles.captionBold.copyWith(color: AppColors.white)),
          ),
        ],
      ),
    );
  }

  String _formatDate(DateTime date) => '${date.day}/${date.month}/${date.year}';
}
