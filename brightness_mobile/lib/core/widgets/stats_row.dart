import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class StatsRow extends StatelessWidget {
  final int postsCount;
  final int likesCount;
  final String? postsLabel;
  final String? likesLabel;

  const StatsRow({
    super.key,
    required this.postsCount,
    required this.likesCount,
    this.postsLabel,
    this.likesLabel,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 32),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          // Posts stat
          _buildStatItem(
            count: postsCount,
            label: postsLabel ?? 'Posts',
          ),
          
          // Divider
          Container(
            width: 1,
            height: 40,
            color: AppTheme.borderColor,
          ),
          
          // Likes stat
          _buildStatItem(
            count: likesCount,
            label: likesLabel ?? 'Likes',
          ),
        ],
      ),
    );
  }

  Widget _buildStatItem({
    required int count,
    required String label,
  }) {
    return Column(
      children: [
        // Number in large bold
        Text(
          _formatCount(count),
          style: const TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
            color: AppTheme.textPrimary,
          ),
        ),
        const SizedBox(height: 4),
        
        // Label below
        Text(
          label,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: AppTheme.textSecondary,
          ),
        ),
      ],
    );
  }

  String _formatCount(int count) {
    if (count >= 1000000) {
      return '${(count / 1000000).toStringAsFixed(1)}M';
    } else if (count >= 1000) {
      return '${(count / 1000).toStringAsFixed(1)}K';
    } else {
      return count.toString();
    }
  }
}
