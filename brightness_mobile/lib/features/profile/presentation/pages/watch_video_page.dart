import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/widgets/video_player_header.dart';
import '../../../../core/widgets/main_video_player.dart';
import '../../../../core/widgets/video_info.dart';
import '../../../../core/widgets/author_info.dart';
import '../../../../core/widgets/video_actions.dart';
import '../../../../core/widgets/related_videos.dart';
import '../../../../shared/services/first_aid_data_service.dart';
import '../controllers/video_controller.dart';
import '../controllers/navigation_controller.dart';

class WatchVideoPage extends StatefulWidget {
  final String? videoId;
  final String? videoUrl;

  const WatchVideoPage({
    super.key,
    this.videoId,
    this.videoUrl,
  });

  @override
  State<WatchVideoPage> createState() => _WatchVideoPageState();
}

class _WatchVideoPageState extends State<WatchVideoPage> {
  @override
  void initState() {
    super.initState();
    // Load video data when page initializes
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (widget.videoId != null) {
        context.read<VideoController>().loadVideo(widget.videoId!);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      appBar: VideoPlayerHeader(
        onMenuPressed: _showMenuOptions,
      ),
      body: Consumer<VideoController>(
        builder: (context, videoController, child) {
          if (videoController.isLoading) {
            return const Center(
              child: CircularProgressIndicator(
                color: AppTheme.primaryColor,
              ),
            );
          }
          
          if (videoController.error != null) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.error_outline,
                    size: 64,
                    color: AppTheme.errorColor,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Error loading video',
                    style: AppTheme.textStyleHeadline3,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    videoController.error!,
                    style: AppTheme.textStyleBody2,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {
                      if (widget.videoId != null) {
                        videoController.loadVideo(widget.videoId!);
                      }
                    },
                    child: const Text('Retry'),
                  ),
                ],
              ),
            );
          }
          
          final video = videoController.currentVideo;
          if (video == null) {
            return const Center(
              child: Text('No video data available'),
            );
          }
          
          return SingleChildScrollView(
            child: Column(
              children: [
                // Main Video Player
                MainVideoPlayer(
                  videoUrl: video.videoUrl,
                  title: video.title,
                  onFullscreen: _toggleFullscreen,
                  onProgressChanged: (progress) => _onProgressChanged(video.id, progress),
                  onPlayPause: _onPlayPause,
                ),
                
                // Video Information
                VideoInfo(
                  title: video.title,
                  duration: video.duration,
                  uploadDate: video.uploadDate,
                  description: video.description,
                  viewCount: video.viewCount,
                  likeCount: video.likeCount,
                ),
                
                // Author Information
                AuthorInfo(
                  name: video.authorName,
                  credentials: video.authorCredentials,
                  avatarUrl: video.authorAvatarUrl,
                  showFollowButton: true,
                  onTap: _navigateToAuthorProfile,
                ),
                
                // Video Actions
                VideoActions(
                  isBookmarked: video.isBookmarked,
                  isSavedOffline: video.isSavedOffline,
                  isLoading: videoController.isLoading,
                  onSaveOffline: () => _handleSaveOffline(video.id),
                  onBookmark: () => _handleBookmark(video.id),
                ),
                
                const SizedBox(height: 24),
                
                // Related Videos
                FutureBuilder<List<RelatedVideoData>>(
                  future: _getRelatedVideosFromService(video.id),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(
                        child: CircularProgressIndicator(
                          color: AppTheme.primaryColor,
                        ),
                      );
                    }
                    
                    if (snapshot.hasError) {
                      return const Center(
                        child: Text('Error loading related videos'),
                      );
                    }
                    
                    final relatedVideos = snapshot.data ?? [];
                    return RelatedVideos(
                      videos: relatedVideos,
                      onViewAll: _navigateToAllVideos,
                      onVideoTap: _navigateToVideo,
                    );
                  },
                ),
                
                const SizedBox(height: 24),
              ],
            ),
          );
        },
      ),
    );
  }

  void _showMenuOptions() {
    showModalBottomSheet(
      context: context,
      builder: (context) => Container(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'Video Options',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: AppTheme.textPrimary,
              ),
            ),
            const SizedBox(height: 24),
            _buildMenuOption('Share Video', Icons.share, _shareVideo),
            _buildMenuOption('Report Video', Icons.report, _reportVideo),
            _buildMenuOption('Download Quality', Icons.download, _selectDownloadQuality),
            _buildMenuOption('Playback Speed', Icons.speed, _selectPlaybackSpeed),
          ],
        ),
      ),
    );
  }

  Widget _buildMenuOption(String title, IconData icon, VoidCallback onTap) {
    return ListTile(
      leading: Icon(icon, color: AppTheme.primaryColor),
      title: Text(title),
      onTap: () {
        Navigator.pop(context);
        onTap();
      },
    );
  }

  void _toggleFullscreen() {
    // Implement fullscreen toggle
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Fullscreen mode toggled'),
        duration: Duration(seconds: 1),
      ),
    );
  }

  void _onProgressChanged(String videoId, double progress) {
    // Track video progress for analytics (touches database)
    context.read<VideoController>().updateVideoProgress(videoId, progress);
  }

  void _onPlayPause(bool isPlaying) {
    // Track play/pause events for analytics
    // This would typically send data to your analytics service
    print('Video ${isPlaying ? 'playing' : 'paused'}');
  }

  void _navigateToAuthorProfile() {
    // Navigate to author's profile page using controller
    final video = context.read<VideoController>().currentVideo;
    if (video != null) {
      context.read<NavigationController>().navigateToUserProfile(
        isOwnProfile: false,
        userId: video.authorName, // In real app, use actual user ID
        context: context,
      );
    }
  }

  void _handleSaveOffline(String videoId) {
    // Use controller to handle save offline (touches database)
    context.read<VideoController>().toggleSaveOffline(videoId);
  }

  void _handleBookmark(String videoId) {
    // Use controller to handle bookmark (touches database)
    context.read<VideoController>().toggleBookmark(videoId);
  }

  void _shareVideo() {
    // Implement share functionality
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Sharing video...'),
        duration: Duration(seconds: 1),
      ),
    );
  }

  void _reportVideo() {
    // Implement report functionality
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Report Video'),
        content: const Text('Are you sure you want to report this video?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Video reported successfully'),
                  backgroundColor: AppTheme.successColor,
                ),
              );
            },
            child: const Text('Report'),
          ),
        ],
      ),
    );
  }

  void _selectDownloadQuality() {
    showModalBottomSheet(
      context: context,
      builder: (context) => Container(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'Select Download Quality',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: AppTheme.textPrimary,
              ),
            ),
            const SizedBox(height: 24),
            _buildQualityOption('High Quality (1080p)', '2.5 GB'),
            _buildQualityOption('Medium Quality (720p)', '1.2 GB'),
            _buildQualityOption('Low Quality (480p)', '800 MB'),
          ],
        ),
      ),
    );
  }

  Widget _buildQualityOption(String quality, String size) {
    return ListTile(
      title: Text(quality),
      subtitle: Text(size),
      trailing: const Icon(Icons.download),
      onTap: () {
        Navigator.pop(context);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Downloading in $quality'),
            backgroundColor: AppTheme.successColor,
          ),
        );
      },
    );
  }

  void _selectPlaybackSpeed() {
    showModalBottomSheet(
      context: context,
      builder: (context) => Container(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'Select Playback Speed',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: AppTheme.textPrimary,
              ),
            ),
            const SizedBox(height: 24),
            _buildSpeedOption('0.5x'),
            _buildSpeedOption('0.75x'),
            _buildSpeedOption('1.0x', isSelected: true),
            _buildSpeedOption('1.25x'),
            _buildSpeedOption('1.5x'),
            _buildSpeedOption('2.0x'),
          ],
        ),
      ),
    );
  }

  Widget _buildSpeedOption(String speed, {bool isSelected = false}) {
    return ListTile(
      title: Text(speed),
      trailing: isSelected ? const Icon(Icons.check, color: AppTheme.primaryColor) : null,
      onTap: () {
        Navigator.pop(context);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Playback speed set to $speed'),
            duration: const Duration(seconds: 1),
          ),
        );
      },
    );
  }

  void _navigateToAllVideos() {
    // Navigate to all videos page using controller
    context.read<NavigationController>().navigateToFirstAidVideos(context: context);
  }

  void _navigateToVideo(RelatedVideoData video) {
    // Navigate to the selected video using controller
    context.read<NavigationController>().navigateToWatchVideo(
      videoId: video.id,
      videoUrl: video.videoUrl,
      context: context,
    );
  }

  Future<List<RelatedVideoData>> _getRelatedVideosFromService(String currentVideoId) async {
    return await FirstAidDataService.getRelatedVideos(currentVideoId, limit: 4);
  }

}
