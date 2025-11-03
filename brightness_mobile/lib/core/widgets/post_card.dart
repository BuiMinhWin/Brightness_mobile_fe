import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class PostCard extends StatelessWidget {
  final String? userAvatarUrl;
  final String userName;
  final String timestamp;
  final String content;
  final String? imageUrl;
  final Color? imageBackgroundColor;
  final VoidCallback? onTap;
  final VoidCallback? onLike;
  final VoidCallback? onComment;
  final bool isLiked;
  final int likeCount;
  final int commentCount;

  const PostCard({
    super.key,
    this.userAvatarUrl,
    required this.userName,
    required this.timestamp,
    required this.content,
    this.imageUrl,
    this.imageBackgroundColor,
    this.onTap,
    this.onLike,
    this.onComment,
    this.isLiked = false,
    this.likeCount = 0,
    this.commentCount = 0,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: AppTheme.surfaceColor,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(13),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // User info header
          _buildUserHeader(),
          
          // Post content
          _buildPostContent(),
          
          // Image/Illustration
          if (imageUrl != null) _buildPostImage(),
          
          // Action buttons
          _buildActionButtons(),
        ],
      ),
    );
  }

  Widget _buildUserHeader() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          // User avatar
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: AppTheme.textHint.withAlpha(51),
            ),
            child: userAvatarUrl != null && userAvatarUrl!.isNotEmpty
                ? ClipOval(
                    child: Image.network(
                      userAvatarUrl!,
                      width: 40,
                      height: 40,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return _buildPlaceholderAvatar();
                      },
                    ),
                  )
                : _buildPlaceholderAvatar(),
          ),
          const SizedBox(width: 12),
          
          // User name and timestamp
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  userName,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: AppTheme.textPrimary,
                  ),
                ),
                Text(
                  timestamp,
                  style: const TextStyle(
                    fontSize: 12,
                    color: AppTheme.textSecondary,
                  ),
                ),
              ],
            ),
          ),
          
          // More options button
          IconButton(
            icon: const Icon(
              Icons.more_vert,
              color: AppTheme.textSecondary,
            ),
            onPressed: () {},
          ),
        ],
      ),
    );
  }

  Widget _buildPostContent() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Text(
        content,
        style: const TextStyle(
          fontSize: 14,
          color: AppTheme.textPrimary,
          height: 1.4,
        ),
      ),
    );
  }

  Widget _buildPostImage() {
    return Container(
      margin: const EdgeInsets.all(16),
      height: 200,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: imageBackgroundColor ?? const Color(0xFFFFE1E6), // Pink background
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: imageUrl != null && imageUrl!.isNotEmpty
            ? Image.network(
                imageUrl!,
                width: double.infinity,
                height: 200,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return _buildPlaceholderImage();
                },
              )
            : _buildPlaceholderImage(),
      ),
    );
  }

  Widget _buildPlaceholderImage() {
    return Container(
      width: double.infinity,
      height: 200,
      decoration: BoxDecoration(
        color: imageBackgroundColor ?? const Color(0xFFFFE1E6),
        borderRadius: BorderRadius.circular(12),
      ),
      child: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.fitness_center,
              size: 48,
              color: Colors.white,
            ),
            SizedBox(height: 8),
            Text(
              'Fitness Equipment',
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActionButtons() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        children: [
          // Like button
          _buildActionButton(
            icon: isLiked ? Icons.favorite : Icons.favorite_border,
            label: likeCount > 0 ? likeCount.toString() : null,
            onTap: onLike,
            isActive: isLiked,
          ),
          const SizedBox(width: 24),
          
          // Comment button
          _buildActionButton(
            icon: Icons.comment_outlined,
            label: commentCount > 0 ? commentCount.toString() : null,
            onTap: onComment,
          ),
          const SizedBox(width: 24),
          
          // Share button
          _buildActionButton(
            icon: Icons.share_outlined,
            onTap: () {},
          ),
        ],
      ),
    );
  }

  Widget _buildActionButton({
    required IconData icon,
    String? label,
    VoidCallback? onTap,
    bool isActive = false,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            size: 20,
            color: isActive ? AppTheme.primaryColor : AppTheme.textSecondary,
          ),
          if (label != null) ...[
            const SizedBox(width: 4),
            Text(
              label,
              style: TextStyle(
                fontSize: 12,
                color: isActive ? AppTheme.primaryColor : AppTheme.textSecondary,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildPlaceholderAvatar() {
    return const Icon(
      Icons.person,
      size: 20,
      color: AppTheme.textHint,
    );
  }
}
