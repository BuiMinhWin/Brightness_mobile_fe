import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class VideoInfo extends StatelessWidget {
  final String title;
  final String duration;
  final String uploadDate;
  final String description;
  final int viewCount;
  final int likeCount;

  const VideoInfo({
    super.key,
    required this.title,
    required this.duration,
    required this.uploadDate,
    required this.description,
    this.viewCount = 0,
    this.likeCount = 0,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Video Title
          Text(
            title,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: AppTheme.textPrimary,
              height: 1.3,
            ),
          ),
          const SizedBox(height: 12),
          
          // Video Meta Information
          _buildVideoMeta(),
          const SizedBox(height: 16),
          
          // Description
          _buildDescription(),
          const SizedBox(height: 16),
          
          // Stats
          _buildStats(),
        ],
      ),
    );
  }

  Widget _buildVideoMeta() {
    return Row(
      children: [
        // Duration
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          decoration: BoxDecoration(
            color: AppTheme.primaryColor.withOpacity(0.1),
            borderRadius: BorderRadius.circular(4),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(
                Icons.access_time,
                size: 14,
                color: AppTheme.primaryColor,
              ),
              const SizedBox(width: 4),
              Text(
                duration,
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: AppTheme.primaryColor,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(width: 12),
        
        // Upload Date
        Text(
          'Uploaded: $uploadDate',
          style: const TextStyle(
            fontSize: 14,
            color: AppTheme.textSecondary,
          ),
        ),
      ],
    );
  }

  Widget _buildDescription() {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppTheme.textHint.withOpacity(0.05),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: AppTheme.borderColor,
          width: 1,
        ),
      ),
      child: Text(
        description,
        style: const TextStyle(
          fontSize: 14,
          color: AppTheme.textPrimary,
          height: 1.5,
        ),
      ),
    );
  }

  Widget _buildStats() {
    return Row(
      children: [
        // View Count
        _buildStatItem(
          icon: Icons.visibility,
          count: _formatCount(viewCount),
          label: 'views',
        ),
        const SizedBox(width: 20),
        
        // Like Count
        _buildStatItem(
          icon: Icons.thumb_up_outlined,
          count: _formatCount(likeCount),
          label: 'likes',
        ),
      ],
    );
  }

  Widget _buildStatItem({
    required IconData icon,
    required String count,
    required String label,
  }) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          icon,
          size: 16,
          color: AppTheme.textSecondary,
        ),
        const SizedBox(width: 4),
        Text(
          count,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: AppTheme.textPrimary,
          ),
        ),
        const SizedBox(width: 2),
        Text(
          label,
          style: const TextStyle(
            fontSize: 14,
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
