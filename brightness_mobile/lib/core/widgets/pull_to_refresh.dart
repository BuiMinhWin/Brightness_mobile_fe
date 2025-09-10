import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class PullToRefresh extends StatelessWidget {
  final Widget child;
  final Future<void> Function() onRefresh;
  final String? refreshText;

  const PullToRefresh({
    super.key,
    required this.child,
    required this.onRefresh,
    this.refreshText,
  });

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: onRefresh,
      color: AppTheme.primaryColor,
      backgroundColor: AppTheme.surfaceColor,
      strokeWidth: 2.0,
      child: child,
    );
  }
}

class PullToRefreshIndicator extends StatelessWidget {
  final String text;
  final bool isRefreshing;

  const PullToRefreshIndicator({
    super.key,
    this.text = 'Pull to refresh',
    this.isRefreshing = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (isRefreshing)
            const CircularProgressIndicator(
              color: AppTheme.primaryColor,
              strokeWidth: 2,
            )
          else ...[
            const Icon(
              Icons.keyboard_arrow_down,
              color: AppTheme.textSecondary,
              size: 24,
            ),
            const SizedBox(height: 8),
            Text(
              text,
              style: const TextStyle(
                color: AppTheme.textSecondary,
                fontSize: 14,
              ),
            ),
          ],
        ],
      ),
    );
  }
}
