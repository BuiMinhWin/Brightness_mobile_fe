import 'package:flutter/material.dart';

class PostActions extends StatefulWidget {
  final int likes;
  final int comments;
  final int shares;
  final bool isLiked;
  final bool isBookmarked;
  final VoidCallback? onLikePressed;
  final VoidCallback? onCommentPressed;
  final VoidCallback? onSharePressed;
  final VoidCallback? onBookmarkPressed;

  const PostActions({
    super.key,
    required this.likes,
    required this.comments,
    required this.shares,
    this.isLiked = false,
    this.isBookmarked = false,
    this.onLikePressed,
    this.onCommentPressed,
    this.onSharePressed,
    this.onBookmarkPressed,
  });

  @override
  State<PostActions> createState() => _PostActionsState();
}

class _PostActionsState extends State<PostActions> {
  late bool _isLiked;
  late bool _isBookmarked;
  late int _likes;

  @override
  void initState() {
    super.initState();
    _isLiked = widget.isLiked;
    _isBookmarked = widget.isBookmarked;
    _likes = widget.likes;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        children: [
          _buildActionButton(
            icon: _isLiked ? Icons.favorite : Icons.favorite_border,
            count: _likes,
            color: _isLiked ? Colors.red : const Color(0xFF6B7280),
            onPressed: () {
              setState(() {
                _isLiked = !_isLiked;
                _likes += _isLiked ? 1 : -1;
              });
              widget.onLikePressed?.call();
            },
          ),
          const SizedBox(width: 24),
          _buildActionButton(
            icon: Icons.chat_bubble_outline,
            count: widget.comments,
            color: const Color(0xFF6B7280),
            onPressed: widget.onCommentPressed,
          ),
          const SizedBox(width: 24),
          _buildActionButton(
            icon: Icons.share_outlined,
            count: widget.shares,
            color: const Color(0xFF6B7280),
            onPressed: widget.onSharePressed,
          ),
          const Spacer(),
          IconButton(
            icon: Icon(
              _isBookmarked ? Icons.bookmark : Icons.bookmark_border,
              color: _isBookmarked ? const Color(0xFF4CAF50) : const Color(0xFF6B7280),
            ),
            onPressed: () {
              setState(() {
                _isBookmarked = !_isBookmarked;
              });
              widget.onBookmarkPressed?.call();
            },
          ),
        ],
      ),
    );
  }

  Widget _buildActionButton({
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
