// lib/features/gamification/presentation/widgets/leaderboard_item.dart
import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/theme/app_theme.dart';

import '../../data/models/leaderboard_user.dart';

class LeaderboardItem extends StatelessWidget {
  final LeaderboardUser user;
  final int rank;

  const LeaderboardItem({
    super.key,
    required this.user,
    required this.rank,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: AppTheme.spacingM),
      padding: const EdgeInsets.symmetric(
        horizontal: AppTheme.spacingL,
        vertical: AppTheme.spacingM,
      ),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(AppTheme.radiusM),
        border: Border.all(
          color: AppColors.borderLight,
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.shadow.withAlpha(13),
            blurRadius: AppTheme.shadowBlur,
            offset: const Offset(0, AppTheme.shadowOffset),
          ),
        ],
      ),
      child: Row(
        children: [
          // Rank
          Container(
            width: AppTheme.avatarS,
            height: AppTheme.avatarS,
            decoration: BoxDecoration(
              color: _getRankColorBackground(),
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Text(
                rank.toString().padLeft(2, '0'),
                style: AppTextStyles.bodySmall.copyWith(
                  fontWeight: FontWeight.w600,
                  color: _getRankColor(),
                ),
              ),
            ),
          ),
          const SizedBox(width: AppTheme.spacingM),
          // Avatar
          Container(
            width: AppTheme.avatarM,
            height: AppTheme.avatarM,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: _getAvatarColors(),
              ),
            ),
            child: Center(
              child: Text(
                user.name.substring(0, 1).toUpperCase(),
                style: AppTextStyles.bodyMedium.copyWith(
                  fontWeight: FontWeight.bold,
                  color: AppColors.white,
                ),
              ),
            ),
          ),
          const SizedBox(width: AppTheme.spacingM),
          // User Info
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  user.name,
                  style: AppTextStyles.bodyMedium.copyWith(
                    fontWeight: FontWeight.w600,
                    color: AppColors.textPrimary,
                  ),
                ),
                const SizedBox(height: AppTheme.spacingXS),
                Text(
                  '${user.points} points',
                  style: AppTextStyles.captionRegular.copyWith(
                    color: AppColors.textSecondary,
                  ),
                ),
              ],
            ),
          ),
          // Trend Icon
          Container(
            width: AppTheme.avatarS,
            height: AppTheme.avatarS,
            decoration: BoxDecoration(
              color: _getTrendColorBackground(),
              shape: BoxShape.circle,
            ),
            child: Icon(
              _getTrendIcon(),
              color: _getTrendColor(),
              size: AppTheme.iconSizeS,
            ),
          ),
        ],
      ),
    );
  }

  /// Rank colors
  Color _getRankColor() {
    if (rank <= 3) return AppColors.successDark;
    if (rank <= 6) return AppColors.success;
    return AppColors.successLight;
  }

  Color _getRankColorBackground() {
    return _getRankColor().withAlpha(26);
  }

  /// Avatar gradient colors
  List<Color> _getAvatarColors() {
    final colors = [
      [AppColors.primaryBlue, AppColors.primaryLightBlue],
      [AppColors.successDark, AppColors.success],
      [AppColors.purpleDark, AppColors.purpleLight],
      [AppColors.orangeDark, AppColors.orangeLight],
      [AppColors.redDark, AppColors.redLight],
      [AppColors.tealDark, AppColors.tealLight],
    ];
    final index = user.id.hashCode.abs() % colors.length;
    return colors[index];
  }

  /// Trend colors
  Color _getTrendColor() {
    return rank % 2 == 0 ? AppColors.primaryBlue : AppColors.redDark;
  }

  Color _getTrendColorBackground() {
    return _getTrendColor().withAlpha(26);
  }

  IconData _getTrendIcon() {
    return rank % 2 == 0 ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down;
  }
}
