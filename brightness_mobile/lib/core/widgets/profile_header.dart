import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class ProfileHeader extends StatelessWidget {
  final String? imageUrl;
  final String name;
  final String jobTitle;
  final String location;
  final String? hobby;
  final String? rank;
  final VoidCallback? onImageTap;

  const ProfileHeader({
    super.key,
    this.imageUrl,
    required this.name,
    required this.jobTitle,
    required this.location,
    this.hobby,
    this.rank,
    this.onImageTap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Large circular avatar
        GestureDetector(
          onTap: onImageTap,
          child: Container(
            width: 120,
            height: 120,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: AppTheme.textHint.withOpacity(0.2), // Light gray background
              border: Border.all(
                color: AppTheme.borderColor,
                width: 2,
              ),
            ),
            child: imageUrl != null && imageUrl!.isNotEmpty
                ? ClipOval(
                    child: Image.network(
                      imageUrl!,
                      width: 120,
                      height: 120,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return _buildPlaceholderAvatar();
                      },
                    ),
                  )
                : _buildPlaceholderAvatar(),
          ),
        ),
        const SizedBox(height: 16),
        
        // User name (bold, large text)
        Text(
          name,
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: AppTheme.textPrimary,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 8),
        
        // Job title
        Text(
          jobTitle,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: AppTheme.textSecondary,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 8),
        
        // Location with pin icon
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.location_on,
              size: 16,
              color: AppTheme.textSecondary,
            ),
            const SizedBox(width: 4),
            Text(
              location,
              style: const TextStyle(
                fontSize: 14,
                color: AppTheme.textSecondary,
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        
        // Hobby and rank labels
        if (hobby != null || rank != null) ...[
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (hobby != null) ...[
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: AppTheme.primaryColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Text(
                    hobby!,
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: AppTheme.primaryColor,
                    ),
                  ),
                ),
                if (rank != null) const SizedBox(width: 8),
              ],
              if (rank != null)
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: AppTheme.secondaryColor.withOpacity(0.3),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Text(
                    rank!,
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: AppTheme.textPrimary,
                    ),
                  ),
                ),
            ],
          ),
        ],
      ],
    );
  }

  Widget _buildPlaceholderAvatar() {
    return const Icon(
      Icons.person,
      size: 60,
      color: AppTheme.textHint,
    );
  }
}
