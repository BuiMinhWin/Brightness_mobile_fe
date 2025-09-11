import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class VideoListItem extends StatelessWidget {
  final String title;
  final String description;
  final String duration;
  final String? thumbnailUrl;
  final String authorName;
  final int viewCount;
  final String timestamp;
  final VoidCallback? onTap;

  const VideoListItem({
    super.key,
    required this.title,
    required this.description,
    required this.duration,
    this.thumbnailUrl,
    required this.authorName,
    required this.viewCount,
    required this.timestamp,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: AppTheme.surfaceColor,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: AppTheme.borderColor,
            width: 1,
          ),
        ),
        child: Row(
          children: [
            // Video Thumbnail
            _buildThumbnail(),
            const SizedBox(width: 12),
            
            // Video Information
            Expanded(
              child: _buildVideoInfo(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildThumbnail() {
    return Container(
      width: 120,
      height: 80,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(6),
        color: AppTheme.textHint.withOpacity(0.1),
      ),
      child: Stack(
        children: [
          // Thumbnail Image
          ClipRRect(
            borderRadius: BorderRadius.circular(6),
            child: thumbnailUrl != null && thumbnailUrl!.isNotEmpty
                ? Image.network(
                    thumbnailUrl!,
                    width: 120,
                    height: 80,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return _buildPlaceholderThumbnail();
                    },
                  )
                : _buildPlaceholderThumbnail(),
          ),
          
          // Duration Overlay
          Positioned(
            bottom: 4,
            right: 4,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.7),
                borderRadius: BorderRadius.circular(3),
              ),
              child: Text(
                duration,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 10,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPlaceholderThumbnail() {
    return Container(
      width: 120,
      height: 80,
      decoration: BoxDecoration(
        color: AppTheme.textHint.withOpacity(0.1),
        borderRadius: BorderRadius.circular(6),
      ),
      child: const Center(
        child: Icon(
          Icons.play_circle_outline,
          color: AppTheme.textHint,
          size: 32,
        ),
      ),
    );
  }

  Widget _buildVideoInfo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Video Title
        Text(
          title,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: AppTheme.textPrimary,
          ),
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
        const SizedBox(height: 4),
        
        // Description
        Text(
          description,
          style: const TextStyle(
            fontSize: 12,
            color: AppTheme.textSecondary,
          ),
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
        const SizedBox(height: 6),
        
        // Author and Stats
        Row(
          children: [
            // Author Name
            Expanded(
              child: Text(
                authorName,
                style: const TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w500,
                  color: AppTheme.textSecondary,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            
            // View Count and Timestamp
            Text(
              '${_formatCount(viewCount)} • $timestamp',
              style: const TextStyle(
                fontSize: 11,
                color: AppTheme.textHint,
              ),
            ),
          ],
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
