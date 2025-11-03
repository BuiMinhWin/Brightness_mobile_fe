import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:brightness_mobile/app/router.dart';
import '../../../../core/theme/app_colors.dart';
import '../presentation/controllers/home_controller.dart';

class CustomBottomNavBar extends StatelessWidget {
  const CustomBottomNavBar({super.key});

  @override
  Widget build(BuildContext context) {
    final selectedIndex = context.select((HomeController c) => c.selectedNavIndex);

    return Container(
      height: 80,
      decoration: BoxDecoration(
        color: AppColors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(26),
            blurRadius: 20,
            offset: const Offset(0, -5),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildNavItem(
            icon: Icons.home_outlined,
            activeIcon: Icons.home,
            label: "Home",
            index: 0,
            selectedIndex: selectedIndex,
            onTap: () => context.read<HomeController>().selectNavItem(0),
          ),
          _buildNavItem(
            icon: Icons.track_changes_outlined,
            activeIcon: Icons.track_changes,
            label: "Tracking",
            index: 1,
            selectedIndex: selectedIndex,
            onTap: () => Navigator.of(context).pushNamed(AppRouter.runMap),
          ),
          _buildCenterNavItem(),
          _buildNavItem(
            icon: Icons.social_distance_outlined,
            activeIcon: Icons.social_distance,
            label: "Social",
            index: 3,
            selectedIndex: selectedIndex,
            onTap: () => Navigator.of(context).pushNamed(AppRouter.feed),
          ),
          _buildNavItem(
            icon: Icons.sports_esports_outlined,
            activeIcon: Icons.sports_esports,
            label: "Game",
            index: 4,
            selectedIndex: selectedIndex,
            onTap: () => Navigator.of(context).pushNamed('/main'),
          ),
        ],
      ),
    );
  }

  Widget _buildNavItem({
    required IconData icon,
    required IconData activeIcon,
    required String label,
    required int index,
    required int selectedIndex,
    required VoidCallback onTap,
  }) {
    final isSelected = selectedIndex == index;

    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            isSelected ? activeIcon : icon,
            color: isSelected ? AppColors.primary : AppColors.textSecondary,
            size: 24,
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              color: isSelected ? AppColors.primary : AppColors.textSecondary,
              fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCenterNavItem() {
    return Container(
      width: 60,
      height: 60,
      decoration: const BoxDecoration(
        color: AppColors.primary,
        shape: BoxShape.circle,
      ),
      child: const Icon(Icons.pets, color: AppColors.white, size: 28),
    );
  }
}
