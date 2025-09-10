import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import 'video_card.dart';
import 'pull_to_refresh.dart';

class VideoFeed extends StatefulWidget {
  final List<FirstAidVideo> videos;
  final bool isLoading;
  final bool hasMore;
  final VoidCallback? onLoadMore;
  final Future<void> Function()? onRefresh;
  final Function(FirstAidVideo)? onVideoTap;
  final Function(FirstAidVideo)? onVideoPlay;
  final Function(FirstAidVideo)? onVideoShare;

  const VideoFeed({
    super.key,
    required this.videos,
    this.isLoading = false,
    this.hasMore = true,
    this.onLoadMore,
    this.onRefresh,
    this.onVideoTap,
    this.onVideoPlay,
    this.onVideoShare,
  });

  @override
  State<VideoFeed> createState() => _VideoFeedState();
}

class _VideoFeedState extends State<VideoFeed> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 200) {
      if (widget.hasMore && !widget.isLoading) {
        widget.onLoadMore?.call();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    if (widget.videos.isEmpty && !widget.isLoading) {
      return _buildEmptyState();
    }

    Widget content = ListView.builder(
      controller: _scrollController,
      padding: const EdgeInsets.only(bottom: 16),
      itemCount: widget.videos.length + (widget.hasMore ? 1 : 0),
      itemBuilder: (context, index) {
        if (index >= widget.videos.length) {
          return _buildLoadMoreButton();
        }

        final video = widget.videos[index];
        return VideoCard(
          video: video,
          onTap: () => widget.onVideoTap?.call(video),
          onPlay: () => widget.onVideoPlay?.call(video),
          onShare: () => widget.onVideoShare?.call(video),
        );
      },
    );

    if (widget.onRefresh != null) {
      content = PullToRefresh(
        onRefresh: widget.onRefresh!,
        child: content,
      );
    }

    return content;
  }

  Widget _buildEmptyState() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.video_library_outlined,
              size: 64,
              color: AppTheme.textHint,
            ),
            const SizedBox(height: 16),
            Text(
              'No videos found',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: AppTheme.textSecondary,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Try adjusting your search or filter',
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

  Widget _buildLoadMoreButton() {
    if (widget.isLoading) {
      return const Padding(
        padding: EdgeInsets.all(16),
        child: Center(
          child: CircularProgressIndicator(
            color: AppTheme.primaryColor,
          ),
        ),
      );
    }

    return Padding(
      padding: const EdgeInsets.all(16),
      child: Center(
        child: ElevatedButton(
          onPressed: widget.onLoadMore,
          style: ElevatedButton.styleFrom(
            backgroundColor: AppTheme.primaryColor,
            foregroundColor: Colors.white,
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          ),
          child: const Text(
            'Load More Videos',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }
}

class LoadMoreWidget extends StatelessWidget {
  final bool isLoading;
  final bool hasMore;
  final VoidCallback? onLoadMore;

  const LoadMoreWidget({
    super.key,
    this.isLoading = false,
    this.hasMore = true,
    this.onLoadMore,
  });

  @override
  Widget build(BuildContext context) {
    if (!hasMore) {
      return const SizedBox.shrink();
    }

    if (isLoading) {
      return const Padding(
        padding: EdgeInsets.all(16),
        child: Center(
          child: CircularProgressIndicator(
            color: AppTheme.primaryColor,
          ),
        ),
      );
    }

    return Padding(
      padding: const EdgeInsets.all(16),
      child: Center(
        child: ElevatedButton(
          onPressed: onLoadMore,
          style: ElevatedButton.styleFrom(
            backgroundColor: AppTheme.primaryColor,
            foregroundColor: Colors.white,
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          ),
          child: const Text(
            'Load More Videos',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }
}
