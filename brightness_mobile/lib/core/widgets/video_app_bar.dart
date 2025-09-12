import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class VideoAppBar extends StatelessWidget implements PreferredSizeWidget {
  final VoidCallback? onBackPressed;
  final VoidCallback? onFilterPressed;
  final String title;
  final bool showFilter;

  const VideoAppBar({
    super.key,
    this.onBackPressed,
    this.onFilterPressed,
    this.title = 'First Aid Videos',
    this.showFilter = true,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset('assets/images/logo b&w-07.png', width: 24, height: 24),
          const SizedBox(width: 8),
          Text(
            title,
            style: const TextStyle(
              fontSize: 20,
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
        if (showFilter)
          IconButton(
            icon: const Icon(Icons.filter_alt, color: AppTheme.textPrimary),
            onPressed: onFilterPressed ?? _showFilterOptions,
          ),
      ],
      centerTitle: false,
    );
  }

  void _showFilterOptions() {
    // This will be handled by the parent widget
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
