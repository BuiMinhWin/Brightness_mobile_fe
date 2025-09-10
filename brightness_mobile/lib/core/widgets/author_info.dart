import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class AuthorInfo extends StatelessWidget {
  final String name;
  final String credentials;
  final String? avatarUrl;
  final VoidCallback? onTap;
  final bool showFollowButton;

  const AuthorInfo({
    super.key,
    required this.name,
    required this.credentials,
    this.avatarUrl,
    this.onTap,
    this.showFollowButton = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          // Author Avatar
          GestureDetector(
            onTap: onTap,
            child: Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppTheme.textHint.withOpacity(0.2),
                border: Border.all(
                  color: AppTheme.borderColor,
                  width: 2,
                ),
              ),
              child: avatarUrl != null && avatarUrl!.isNotEmpty
                  ? ClipOval(
                      child: Image.network(
                        avatarUrl!,
                        width: 50,
                        height: 50,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return _buildPlaceholderAvatar();
                        },
                      ),
                    )
                  : _buildPlaceholderAvatar(),
            ),
          ),
          const SizedBox(width: 12),
          
          // Author Details
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Author Name
                Text(
                  name,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: AppTheme.textPrimary,
                  ),
                ),
                const SizedBox(height: 2),
                
                // Credentials
                Text(
                  credentials,
                  style: const TextStyle(
                    fontSize: 14,
                    color: AppTheme.textSecondary,
                  ),
                ),
              ],
            ),
          ),
          
          // Follow Button (if enabled)
          if (showFollowButton)
            ElevatedButton(
              onPressed: () => _handleFollow(context),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppTheme.primaryColor,
                foregroundColor: Colors.white,
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                minimumSize: const Size(0, 32),
              ),
              child: const Text(
                'Follow',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildPlaceholderAvatar() {
    return const Icon(
      Icons.person,
      size: 24,
      color: AppTheme.textHint,
    );
  }

  void _handleFollow(BuildContext context) {
    // Implement follow functionality
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Following $name'),
        duration: const Duration(seconds: 1),
      ),
    );
  }
}
