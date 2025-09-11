import 'package:flutter/material.dart';
import 'package:brightness_mobile/app/router.dart';
import '../../../../core/theme/app_colors.dart';

class HomeHeaderBar extends StatelessWidget {
  const HomeHeaderBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Left actions
          Row(
            children: [
              IconButton(
                onPressed: () => Navigator.of(context).pushNamed(AppRouter.settingsPage),
                icon: const Icon(Icons.settings_outlined),
                color: AppColors.textPrimary,
                iconSize: 24,
                tooltip: 'Settings',
                splashRadius: 22,
              ),
              const SizedBox(width: 4),
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.add),
                color: AppColors.textPrimary,
                iconSize: 26,
                splashRadius: 22,
              ),
            ],
          ),

          // Center logo
          Container(
            width: 48,
            height: 48,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              image: DecorationImage(
                image: AssetImage('assets/images/logo b&w-07.png'),
                fit: BoxFit.cover,
                filterQuality: FilterQuality.high,
              ),
            ),
          ),

          // Right actions
          Row(
            children: [
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.notifications_none_rounded),
                color: AppColors.textPrimary,
                iconSize: 24,
                splashRadius: 22,
              ),
              const SizedBox(width: 4),
              IconButton(
                onPressed: () => Navigator.of(context).pushNamed(AppRouter.profile),
                icon: const Icon(Icons.person_outline),
                color: AppColors.textPrimary,
                iconSize: 24,
                splashRadius: 22,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
