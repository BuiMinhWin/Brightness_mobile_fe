import 'package:flutter/material.dart';

class PostAuthorInfo extends StatelessWidget {
  final bool isFollowing;
  final VoidCallback? onFollowPressed;
  final Map<String, dynamic>? postData;

  const PostAuthorInfo({
    super.key,
    required this.isFollowing,
    this.onFollowPressed,
    this.postData,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          GestureDetector(
            onTap: () {
              // TODO: Navigate to user profile
            },
              child: CircleAvatar(
                radius: 25,
                backgroundColor: const Color(0xFFE5E7EB),
                backgroundImage: postData?['userAvatar'] != null 
                    ? NetworkImage(postData!['userAvatar']) 
                    : null,
                child: postData?['userAvatar'] == null 
                    ? Text(
                        _getInitials(postData?['username'] ?? 'User'),
                        style: const TextStyle(
                          color: Color(0xFF6B7280),
                          fontWeight: FontWeight.w600,
                          fontSize: 18,
                        ),
                      )
                    : null,
              ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                GestureDetector(
                  onTap: () {
                    // TODO: Navigate to user profile
                  },
                  child: Text(
                    postData?['username'] ?? 'User',
                    style: const TextStyle(
                      color: Color(0xFF1F2937),
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                const SizedBox(height: 2),
                const Text(
                  'Marathon Runner',
                  style: TextStyle(
                    color: Color(0xFF6B7280),
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
          ElevatedButton(
            onPressed: onFollowPressed,
            style: ElevatedButton.styleFrom(
              backgroundColor: isFollowing 
                  ? Colors.grey[300] 
                  : const Color(0xFF4CAF50),
              foregroundColor: isFollowing 
                  ? const Color(0xFF6B7280) 
                  : Colors.white,
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(18),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
              minimumSize: const Size(0, 36),
            ),
            child: Text(
              isFollowing ? 'Following' : 'Follow',
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }

  String _getInitials(String name) {
    if (name.isEmpty) return 'U';
    final words = name.trim().split(' ');
    if (words.length >= 2) {
      return '${words[0][0]}${words[1][0]}'.toUpperCase();
    }
    return name[0].toUpperCase();
  }
}
