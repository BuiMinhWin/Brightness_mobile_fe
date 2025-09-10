import 'package:flutter/material.dart';
import 'post_header.dart';
import 'post_content.dart';
import 'post_image.dart';
import 'post_actions.dart';

class SocialPostCard extends StatelessWidget {
  final String username;
  final String timestamp;
  final String content;
  final List<String> imageUrls;
  final String? avatarUrl;
  final int likes;
  final int comments;
  final int shares;
  final bool isLiked;
  final bool isBookmarked;
  final VoidCallback? onMorePressed;
  final VoidCallback? onLikePressed;
  final VoidCallback? onCommentPressed;
  final VoidCallback? onSharePressed;
  final VoidCallback? onBookmarkPressed;
  final VoidCallback? onImageTap;
  final VoidCallback? onPostTap;

  const SocialPostCard({
    super.key,
    required this.username,
    required this.timestamp,
    required this.content,
    this.imageUrls = const [],
    this.avatarUrl,
    required this.likes,
    required this.comments,
    required this.shares,
    this.isLiked = false,
    this.isBookmarked = false,
    this.onMorePressed,
    this.onLikePressed,
    this.onCommentPressed,
    this.onSharePressed,
    this.onBookmarkPressed,
    this.onImageTap,
    this.onPostTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPostTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        decoration: BoxDecoration(
          color: Colors.white,
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
            PostHeader(
              username: username,
              timestamp: timestamp,
              avatarUrl: avatarUrl,
              onMorePressed: onMorePressed,
            ),
            PostContent(content: content),
            if (imageUrls.isNotEmpty)
              PostImage(
                imageUrls: imageUrls,
                onImageTap: onImageTap,
              ),
            PostActions(
              likes: likes,
              comments: comments,
              shares: shares,
              isLiked: isLiked,
              isBookmarked: isBookmarked,
              onLikePressed: onLikePressed,
              onCommentPressed: onCommentPressed,
              onSharePressed: onSharePressed,
              onBookmarkPressed: onBookmarkPressed,
            ),
          ],
        ),
      ),
    );
  }
}
