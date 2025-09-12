import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class VideoPlayerHeader extends StatelessWidget implements PreferredSizeWidget {
  final VoidCallback? onBackPressed;
  final VoidCallback? onMenuPressed;
  final String title;
  final bool showMenu;

  const VideoPlayerHeader({
    super.key,
    this.onBackPressed,
    this.onMenuPressed,
    this.title = 'Watch Video',
    this.showMenu = true,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset('assets/images/logo b&w-07.png', width: 24, height: 24),
          const SizedBox(width: 8),
          const SizedBox(width: 8),
          Text(
            title,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: AppTheme.textPrimary,
            ),
          ),
        ],
      ),
      backgroundColor: AppTheme.backgroundColor,
      elevation: 0,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back, color: AppTheme.textPrimary),
        onPressed: onBackPressed ?? () => Navigator.of(context).pop(),
      ),
      actions: [
        if (showMenu)
          IconButton(
            icon: const Icon(Icons.more_vert, color: AppTheme.textPrimary),
            onPressed: onMenuPressed ?? _showMenuOptions,
          ),
      ],
      centerTitle: false,
    );
  }

  void _showMenuOptions() {
    // This will be handled by the parent widget
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
