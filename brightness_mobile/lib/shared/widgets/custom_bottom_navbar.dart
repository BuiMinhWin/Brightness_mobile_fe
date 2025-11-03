
import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/theme/app_theme.dart';

class CustomBottomNavBar extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;

  const CustomBottomNavBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 90,
      decoration: BoxDecoration(
        color: AppColors.white,
        boxShadow: [
          BoxShadow(
            color: AppTheme.textPrimary.withAlpha(26),
            blurRadius: 10,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: SafeArea(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _buildNavItem(0, Icons.home_outlined, Icons.home, 'Home'),
            _buildNavItem(1, Icons.event_outlined, Icons.event, 'Event'),
            _buildNavItem(
              2,
              Icons.bookmark_outline,
              Icons.bookmark,
              'Yours',
              isSpecial: true,
            ),
            _buildNavItem(3, Icons.videocam_outlined, Icons.videocam, 'Video'),
            _buildNavItem(
              4,
              Icons.leaderboard_outlined,
              Icons.leaderboard,
              'Leaderboard',
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNavItem(
    int index,
    IconData icon,
    IconData activeIcon,
    String label, {
    bool isSpecial = false,
  }) {
    final isActive = currentIndex == index;

    return GestureDetector(
      onTap: () => onTap(index),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(
          vertical: AppTheme.spacingS,
          horizontal: AppTheme.spacingS + 4,
        ),
        decoration: isActive && isSpecial
            ? BoxDecoration(
                color: AppColors.primary,
                borderRadius: BorderRadius.circular(AppTheme.radiusM + 12),
              )
            : null,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
        
            AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              child: Icon(
                isActive ? activeIcon : icon,
                color: isActive
                    ? (isSpecial ? AppColors.white : AppColors.primary)
                    : AppTheme.textSecondary,
                size: AppTheme.iconSizeM,
              ),
            ),
            const SizedBox(height: AppTheme.spacingXS),
            AnimatedDefaultTextStyle(
              duration: const Duration(milliseconds: 200),
              style: AppTextStyles.caption.copyWith(
                fontWeight: isActive
                    ? AppTheme.fontWeightSemiBold
                    : AppTheme.fontWeightRegular,
                color: isActive
                    ? (isSpecial ? AppColors.white : AppColors.primary)
                    : AppTheme.textSecondary,
              ),
              child: Text(label),
            ),
          ],
        ),
      ),
    );
  }
}
