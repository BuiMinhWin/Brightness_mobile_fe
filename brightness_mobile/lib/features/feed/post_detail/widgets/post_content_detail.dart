import 'package:flutter/material.dart';

class PostContentDetail extends StatelessWidget {
  final Map<String, dynamic>? postData;

  const PostContentDetail({
    super.key,
    this.postData,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            _getPostTitle(),
            style: const TextStyle(
              color: Color(0xFF1F2937),
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            postData?['timestamp'] ?? 'Unknown time',
            style: const TextStyle(
              color: Color(0xFF6B7280),
              fontSize: 14,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            postData?['content'] ?? 'No content available',
            style: const TextStyle(
              color: Color(0xFF1F2937),
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }

  String _getPostTitle() {
    final content = postData?['content'] ?? '';
    if (content.isEmpty) return 'Post';
    
    // Extract first line or first sentence as title
    final lines = content.split('\n');
    if (lines.isNotEmpty) {
      final firstLine = lines[0].trim();
      if (firstLine.length > 50) {
        return '${firstLine.substring(0, 47)}...';
      }
      return firstLine;
    }
    
    return 'Post';
  }
}
