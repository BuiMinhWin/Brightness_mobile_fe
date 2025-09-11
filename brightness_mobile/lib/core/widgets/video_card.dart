import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../theme/app_theme.dart';

class VideoCard extends StatefulWidget {
  final FirstAidVideo video;
  final VoidCallback? onTap;
  final VoidCallback? onPlay;
  final VoidCallback? onShare;

  const VideoCard({
    super.key,
    required this.video,
    this.onTap,
    this.onPlay,
    this.onShare,
  });

  @override
  State<VideoCard> createState() => _VideoCardState();
}

class _VideoCardState extends State<VideoCard> {
  bool _isPlaying = false;
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: AppTheme.surfaceColor,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Video Thumbnail with iFrame
          _buildVideoThumbnail(),
          
          // Video Information
          _buildVideoInfo(),
          
          // Author and Stats
          _buildAuthorInfo(),
          
          // Hashtags
          _buildHashtags(),
        ],
      ),
    );
  }

  Widget _buildVideoThumbnail() {
    return GestureDetector(
      onTap: widget.onPlay ?? _handlePlay,
      child: Container(
        height: 200,
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
          color: AppTheme.textHint.withOpacity(0.1),
        ),
        child: Stack(
          children: [
            // Video Thumbnail/Preview
            ClipRRect(
              borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
              child: widget.video.thumbnailUrl != null
                  ? Image.network(
                      widget.video.thumbnailUrl!,
                      width: double.infinity,
                      height: 200,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return _buildPlaceholderThumbnail();
                      },
                    )
                  : _buildPlaceholderThumbnail(),
            ),
            
            // Play Button Overlay
            Center(
              child: Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.7),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.play_arrow,
                  color: Colors.white,
                  size: 30,
                ),
              ),
            ),
            
            // Duration Overlay
            Positioned(
              bottom: 8,
              right: 8,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.7),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(
                      Icons.access_time,
                      color: Colors.white,
                      size: 12,
                    ),
                    const SizedBox(width: 2),
                    Text(
                      widget.video.duration,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            
            // Medical Cross Icon
            Positioned(
              top: 8,
              left: 8,
              child: Container(
                padding: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                  color: AppTheme.primaryColor.withOpacity(0.9),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: const Icon(
                  Icons.medical_services,
                  color: Colors.white,
                  size: 16,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPlaceholderThumbnail() {
    return Container(
      width: double.infinity,
      height: 200,
      decoration: BoxDecoration(
        color: widget.video.categoryColor.withOpacity(0.1),
        borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              _getCategoryIcon(widget.video.category),
              size: 48,
              color: widget.video.categoryColor,
            ),
            const SizedBox(height: 8),
            Text(
              widget.video.category,
              style: TextStyle(
                color: widget.video.categoryColor,
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildVideoInfo() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Title
          Text(
            widget.video.title,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: AppTheme.textPrimary,
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 8),
          
          // Description
          Text(
            widget.video.description,
            style: const TextStyle(
              fontSize: 14,
              color: AppTheme.textSecondary,
              height: 1.4,
            ),
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }

  Widget _buildAuthorInfo() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          // Author Avatar
          Container(
            width: 32,
            height: 32,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: AppTheme.textHint.withOpacity(0.2),
            ),
            child: widget.video.authorAvatarUrl != null
                ? ClipOval(
                    child: Image.network(
                      widget.video.authorAvatarUrl!,
                      width: 32,
                      height: 32,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return _buildPlaceholderAvatar();
                      },
                    ),
                  )
                : _buildPlaceholderAvatar(),
          ),
          const SizedBox(width: 8),
          
          // Author Name
          Expanded(
            child: Text(
              widget.video.authorName,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: AppTheme.textPrimary,
              ),
            ),
          ),
          
          // View Count and Timestamp
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                '${widget.video.viewCount} views',
                style: const TextStyle(
                  fontSize: 12,
                  color: AppTheme.textSecondary,
                ),
              ),
              Text(
                widget.video.timestamp,
                style: const TextStyle(
                  fontSize: 12,
                  color: AppTheme.textSecondary,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildHashtags() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Wrap(
        spacing: 8,
        runSpacing: 4,
        children: widget.video.hashtags.map((hashtag) {
          return Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: hashtag.color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: hashtag.color.withOpacity(0.3),
                width: 1,
              ),
            ),
            child: Text(
              '#${hashtag.text}',
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: hashtag.color,
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildPlaceholderAvatar() {
    return const Icon(
      Icons.person,
      size: 16,
      color: AppTheme.textHint,
    );
  }

  IconData _getCategoryIcon(String category) {
    switch (category.toLowerCase()) {
      case 'muscle injury':
        return Icons.fitness_center;
      case 'heat exhaustion':
        return Icons.wb_sunny;
      case 'recovery':
        return Icons.healing;
      case 'sprains':
        return Icons.accessibility_new;
      default:
        return Icons.medical_services;
    }
  }

  void _handlePlay() {
    setState(() {
      _isLoading = true;
    });

    // Simulate loading
    Future.delayed(const Duration(seconds: 1), () {
      if (mounted) {
        setState(() {
          _isLoading = false;
          _isPlaying = true;
        });
        
        // Show video player dialog
        _showVideoPlayer();
      }
    });
  }

  void _showVideoPlayer() {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) => Dialog(
        backgroundColor: Colors.transparent,
        child: Container(
          width: double.infinity,
          height: 300,
          decoration: BoxDecoration(
            color: Colors.black,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Stack(
            children: [
              // Video Player Placeholder
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.play_circle_filled,
                      color: Colors.white,
                      size: 64,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'Video Player',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      widget.video.title,
                      style: const TextStyle(
                        color: Colors.white70,
                        fontSize: 14,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
              
              // Close Button
              Positioned(
                top: 8,
                right: 8,
                child: IconButton(
                  icon: const Icon(
                    Icons.close,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                    setState(() {
                      _isPlaying = false;
                    });
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Data model for First Aid Videos
class FirstAidVideo {
  final String id;
  final String title;
  final String description;
  final String duration;
  final String category;
  final Color categoryColor;
  final String authorName;
  final String? authorAvatarUrl;
  final int viewCount;
  final String timestamp;
  final String? thumbnailUrl;
  final String? videoUrl;
  final List<HashtagData> hashtags;

  const FirstAidVideo({
    required this.id,
    required this.title,
    required this.description,
    required this.duration,
    required this.category,
    required this.categoryColor,
    required this.authorName,
    this.authorAvatarUrl,
    required this.viewCount,
    required this.timestamp,
    this.thumbnailUrl,
    this.videoUrl,
    required this.hashtags,
  });
}

class HashtagData {
  final String text;
  final Color color;

  const HashtagData({
    required this.text,
    required this.color,
  });
}
