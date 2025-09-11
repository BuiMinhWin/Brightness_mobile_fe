import 'package:flutter/material.dart';
import '../../widgets/hashtag_text.dart';

class PostInteractions extends StatelessWidget {
  final bool isLiked;
  final bool isBookmarked;
  final int likesCount;
  final int commentsCount;
  final VoidCallback? onLikePressed;
  final VoidCallback? onBookmarkPressed;

  const PostInteractions({
    super.key,
    required this.isLiked,
    required this.isBookmarked,
    required this.likesCount,
    required this.commentsCount,
    this.onLikePressed,
    this.onBookmarkPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Hashtags
          const HashtagText(
            text: '#Running #10K #PersonalBest',
          ),
          const SizedBox(height: 16),
          // Engagement bar
          Row(
            children: [
              _buildEngagementButton(
                icon: isLiked ? Icons.favorite : Icons.favorite_border,
                count: likesCount,
                color: isLiked ? Colors.red : const Color(0xFF6B7280),
                onPressed: onLikePressed,
              ),
              const SizedBox(width: 24),
              _buildEngagementButton(
                icon: Icons.chat_bubble_outline,
                count: commentsCount,
                color: const Color(0xFF6B7280),
                onPressed: () {
                  // TODO: Scroll to comments section
                },
              ),
              const SizedBox(width: 24),
              _buildEngagementButton(
                icon: Icons.share_outlined,
                count: 0,
                color: const Color(0xFF6B7280),
                onPressed: () {
                  // TODO: Implement share functionality
                },
              ),
              const Spacer(),
              IconButton(
                icon: Icon(
                  isBookmarked ? Icons.bookmark : Icons.bookmark_border,
                  color: isBookmarked ? const Color(0xFF4CAF50) : const Color(0xFF6B7280),
                ),
                onPressed: onBookmarkPressed,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildEngagementButton({
    required IconData icon,
    required int count,
    required Color color,
    VoidCallback? onPressed,
  }) {
    return GestureDetector(
      onTap: onPressed,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            color: color,
            size: 24,
          ),
          const SizedBox(width: 4),
          Text(
            _formatCount(count),
            style: TextStyle(
              color: color,
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  String _formatCount(int count) {
    if (count >= 1000000) {
      return '${(count / 1000000).toStringAsFixed(1)}M';
    } else if (count >= 1000) {
      return '${(count / 1000).toStringAsFixed(1)}K';
    }
    return count.toString();
  }
}
