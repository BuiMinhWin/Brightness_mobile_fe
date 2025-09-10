import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import 'video_list_item.dart';

class RelatedVideos extends StatelessWidget {
  final List<RelatedVideoData> videos;
  final VoidCallback? onViewAll;
  final Function(RelatedVideoData)? onVideoTap;
  final bool isLoading;

  const RelatedVideos({
    super.key,
    required this.videos,
    this.onViewAll,
    this.onVideoTap,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Section Header
          _buildSectionHeader(),
          const SizedBox(height: 16),
          
          // Videos List
          if (isLoading)
            _buildLoadingState()
          else if (videos.isEmpty)
            _buildEmptyState()
          else
            _buildVideosList(),
        ],
      ),
    );
  }

  Widget _buildSectionHeader() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text(
            'More First Aid Videos',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: AppTheme.textPrimary,
            ),
          ),
          if (onViewAll != null)
            TextButton(
              onPressed: onViewAll,
              child: const Text(
                'View All',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: AppTheme.primaryColor,
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildLoadingState() {
    return const Padding(
      padding: EdgeInsets.all(32),
      child: Center(
        child: CircularProgressIndicator(
          color: AppTheme.primaryColor,
        ),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Padding(
      padding: const EdgeInsets.all(32),
      child: Center(
        child: Column(
          children: [
            Icon(
              Icons.video_library_outlined,
              size: 48,
              color: AppTheme.textHint,
            ),
            const SizedBox(height: 16),
            Text(
              'No related videos',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: AppTheme.textSecondary,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Check back later for more content',
              style: TextStyle(
                fontSize: 14,
                color: AppTheme.textHint,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildVideosList() {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: videos.length,
      itemBuilder: (context, index) {
        final video = videos[index];
        return VideoListItem(
          title: video.title,
          description: video.description,
          duration: video.duration,
          thumbnailUrl: video.thumbnailUrl,
          authorName: video.authorName,
          viewCount: video.viewCount,
          timestamp: video.timestamp,
          onTap: () => onVideoTap?.call(video),
        );
      },
    );
  }
}

// Data model for related videos
class RelatedVideoData {
  final String id;
  final String title;
  final String description;
  final String duration;
  final String? thumbnailUrl;
  final String authorName;
  final int viewCount;
  final String timestamp;
  final String? videoUrl;

  const RelatedVideoData({
    required this.id,
    required this.title,
    required this.description,
    required this.duration,
    this.thumbnailUrl,
    required this.authorName,
    required this.viewCount,
    required this.timestamp,
    this.videoUrl,
  });
}
