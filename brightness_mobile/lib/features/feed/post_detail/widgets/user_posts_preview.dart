import 'package:flutter/material.dart';

class UserPostsPreview extends StatelessWidget {
  const UserPostsPreview({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'More from Alex Thompson',
            style: TextStyle(
              color: Color(0xFF1F2937),
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          SizedBox(
            height: 120,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: _getSamplePosts().length,
              itemBuilder: (context, index) {
                final post = _getSamplePosts()[index];
                return _buildPostThumbnail(post);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPostThumbnail(Map<String, dynamic> post) {
    return GestureDetector(
      onTap: () {
        // TODO: Navigate to post detail
      },
      child: Container(
        width: 120,
        margin: const EdgeInsets.only(right: 12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: const Color(0xFFF3F4F6),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Thumbnail image
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(12),
                    topRight: Radius.circular(12),
                  ),
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: post['gradientColors'],
                  ),
                ),
                child: Center(
                  child: Icon(
                    post['icon'],
                    color: Colors.white,
                    size: 32,
                  ),
                ),
              ),
            ),
            // Post info
            Padding(
              padding: const EdgeInsets.all(8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    post['title'],
                    style: const TextStyle(
                      color: Color(0xFF1F2937),
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 2),
                  Text(
                    post['timestamp'],
                    style: const TextStyle(
                      color: Color(0xFF6B7280),
                      fontSize: 10,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<Map<String, dynamic>> _getSamplePosts() {
    return [
      {
        'title': 'Evening 5K Recovery Run',
        'timestamp': '2d ago',
        'icon': Icons.directions_run,
        'gradientColors': [
          const Color(0xFF4CAF50).withAlpha(204),
          const Color(0xFF2196F3).withAlpha(204),
        ],
      },
      {
        'title': 'Hill Training Session',
        'timestamp': '4d ago',
        'icon': Icons.terrain,
        'gradientColors': [
          const Color(0xFFFF9800).withAlpha(204),
          const Color(0xFF4CAF50).withAlpha(204),
        ],
      },
      {
        'title': 'Long Run Sunday',
        'timestamp': '1w ago',
        'icon': Icons.timeline,
        'gradientColors': [
          const Color(0xFF9C27B0).withAlpha(204),
          const Color(0xFF2196F3).withAlpha(204),
        ],
      },
      {
        'title': 'Speed Workout',
        'timestamp': '1w ago',
        'icon': Icons.speed,
        'gradientColors': [
          const Color(0xFFE91E63).withAlpha(204),
          const Color(0xFFFF9800).withAlpha(204),
        ],
      },
    ];
  }
}
