import 'package:flutter/material.dart';

class PostAuthorInfo extends StatelessWidget {
  final bool isFollowing;
  final VoidCallback? onFollowPressed;

  const PostAuthorInfo({
    super.key,
    required this.isFollowing,
    this.onFollowPressed,
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
              backgroundImage: null, // TODO: Add user avatar image
              child: const Text(
                'AT',
                style: TextStyle(
                  color: Color(0xFF6B7280),
                  fontWeight: FontWeight.w600,
                  fontSize: 18,
                ),
              ),
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
                  child: const Text(
                    'Alex Thompson',
                    style: TextStyle(
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
          SizedBox(
            height: 36,
            child: ElevatedButton(
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
                padding: const EdgeInsets.symmetric(horizontal: 20),
              ),
              child: Text(
                isFollowing ? 'Following' : 'Follow',
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
