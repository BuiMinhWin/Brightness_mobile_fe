import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import 'post_card.dart';

class FeedSection extends StatelessWidget {
  final List<PostData> posts;
  final bool isLoading;
  final VoidCallback? onRefresh;
  final Function(PostData)? onPostTap;
  final Function(PostData)? onLike;
  final Function(PostData)? onComment;

  const FeedSection({
    super.key,
    required this.posts,
    this.isLoading = false,
    this.onRefresh,
    this.onPostTap,
    this.onLike,
    this.onComment,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Section header
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16),
            child: Text(
              'Posts',
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: AppTheme.textPrimary,
              ),
            ),
          ),
          
          // Posts list
          if (isLoading)
            _buildLoadingState()
          else if (posts.isEmpty)
            _buildEmptyState()
          else
            _buildPostsList(),
        ],
      ),
    );
  }

  Widget _buildLoadingState() {
    return const Center(
      child: Padding(
        padding: EdgeInsets.all(32),
        child: CircularProgressIndicator(
          color: AppTheme.primaryColor,
        ),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Container(
      padding: const EdgeInsets.all(32),
      child: Column(
        children: [
          Icon(
            Icons.post_add,
            size: 64,
            color: AppTheme.textHint,
          ),
          const SizedBox(height: 16),
          Text(
            'No posts yet',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w500,
              color: AppTheme.textSecondary,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Start sharing your thoughts!',
            style: TextStyle(
              fontSize: 14,
              color: AppTheme.textHint,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPostsList() {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: posts.length,
      itemBuilder: (context, index) {
        final post = posts[index];
        return PostCard(
          userAvatarUrl: post.userAvatarUrl,
          userName: post.userName,
          timestamp: post.timestamp,
          content: post.content,
          imageUrl: post.imageUrl,
          imageBackgroundColor: post.imageBackgroundColor,
          isLiked: post.isLiked,
          likeCount: post.likeCount,
          commentCount: post.commentCount,
          onTap: () => onPostTap?.call(post),
          onLike: () => onLike?.call(post),
          onComment: () => onComment?.call(post),
        );
      },
    );
  }
}

// Data model for posts
class PostData {
  final String? userAvatarUrl;
  final String userName;
  final String timestamp;
  final String content;
  final String? imageUrl;
  final Color? imageBackgroundColor;
  final bool isLiked;
  final int likeCount;
  final int commentCount;

  const PostData({
    this.userAvatarUrl,
    required this.userName,
    required this.timestamp,
    required this.content,
    this.imageUrl,
    this.imageBackgroundColor,
    this.isLiked = false,
    this.likeCount = 0,
    this.commentCount = 0,
  });

  PostData copyWith({
    String? userAvatarUrl,
    String? userName,
    String? timestamp,
    String? content,
    String? imageUrl,
    Color? imageBackgroundColor,
    bool? isLiked,
    int? likeCount,
    int? commentCount,
  }) {
    return PostData(
      userAvatarUrl: userAvatarUrl ?? this.userAvatarUrl,
      userName: userName ?? this.userName,
      timestamp: timestamp ?? this.timestamp,
      content: content ?? this.content,
      imageUrl: imageUrl ?? this.imageUrl,
      imageBackgroundColor: imageBackgroundColor ?? this.imageBackgroundColor,
      isLiked: isLiked ?? this.isLiked,
      likeCount: likeCount ?? this.likeCount,
      commentCount: commentCount ?? this.commentCount,
    );
  }
}
