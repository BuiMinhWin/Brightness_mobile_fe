
import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../theme/app_text_styles.dart';

class BottomNavbar extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;

  const BottomNavbar({
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
        border: Border(
          top: BorderSide(
            color: AppColors.border,
            width: 1,
          ),
        ),
      ),
      child: SafeArea(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _buildNavItem(
              index: 0,
              icon: Icons.home_outlined,
              activeIcon: Icons.home,
              label: 'Home',
            ),
            _buildNavItem(
              index: 1,
              icon: Icons.event_outlined,
              activeIcon: Icons.event,
              label: 'Event',
            ),
            _buildNavItem(
              index: 2,
              icon: Icons.bookmark_outline,
              activeIcon: Icons.bookmark,
              label: 'Yours',
              isSpecial: true,
            ),
            _buildNavItem(
              index: 3,
              icon: Icons.videocam_outlined,
              activeIcon: Icons.videocam,
              label: 'Video',
            ),
            _buildNavItem(
              index: 4,
              icon: Icons.leaderboard_outlined,
              activeIcon: Icons.leaderboard,
              label: 'Leaderboard',
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNavItem({
    required int index,
    required IconData icon,
    required IconData activeIcon,
    required String label,
    bool isSpecial = false,
  }) {
    final isActive = currentIndex == index;
    
    return GestureDetector(
      onTap: () => onTap(index),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
        decoration: isActive && isSpecial
            ? BoxDecoration(
                color: AppColors.success,
                borderRadius: BorderRadius.circular(20),
              )
            : null,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              isActive ? activeIcon : icon,
              color: isActive
                  ? (isSpecial ? AppColors.white : AppColors.success)
                  : AppColors.textSecondary,
              size: 24,
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: AppTextStyles.caption.copyWith(
                fontWeight: isActive ? FontWeight.w600 : FontWeight.w400,
                color: isActive
                    ? (isSpecial ? AppColors.white : AppColors.success)
                    : AppColors.textSecondary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}