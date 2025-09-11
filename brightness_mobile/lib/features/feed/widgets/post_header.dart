import 'package:flutter/material.dart';

class PostHeader extends StatelessWidget {
  final String username;
  final String timestamp;
  final String? avatarUrl;
  final VoidCallback? onMorePressed;

  const PostHeader({
    super.key,
    required this.username,
    required this.timestamp,
    this.avatarUrl,
    this.onMorePressed,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          CircleAvatar(
            radius: 20,
            backgroundColor: const Color(0xFFE5E7EB),
            backgroundImage: avatarUrl != null 
                ? NetworkImage(avatarUrl!) 
                : null,
            child: avatarUrl == null 
                ? Text(
                    username.isNotEmpty ? username[0].toUpperCase() : 'U',
                    style: const TextStyle(
                      color: Color(0xFF6B7280),
                      fontWeight: FontWeight.w600,
                    ),
                  )
                : null,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  username,
                  style: const TextStyle(
                    color: Color(0xFF1F2937),
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  timestamp,
                  style: const TextStyle(
                    color: Color(0xFF6B7280),
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
          IconButton(
            icon: const Icon(
              Icons.more_horiz,
              color: Color(0xFF6B7280),
            ),
            onPressed: onMorePressed,
          ),
        ],
      ),
    );
  }
}
