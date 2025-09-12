import 'package:flutter/material.dart';
import 'post_stats_overlay.dart';

class PostMedia extends StatelessWidget {
  final Map<String, dynamic>? postData;

  const PostMedia({
    super.key,
    this.postData,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Column(
        children: [
          // Main running photo with stats overlay
          GestureDetector(
            onTap: () {
              // TODO: Open full-screen image viewer
            },
            child: Container(
              height: 300,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: const Color(0xFFF3F4F6),
              ),
              child: Stack(
                children: [
                  // Placeholder for main running photo
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          const Color(0xFF4CAF50).withOpacity(0.1),
                          const Color(0xFF2196F3).withOpacity(0.1),
                        ],
                      ),
                    ),
                    child: const Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.directions_run,
                            size: 64,
                            color: Color(0xFF4CAF50),
                          ),
                          SizedBox(height: 8),
                          Text(
                            'Trail Running Photo',
                            style: TextStyle(
                              color: Color(0xFF6B7280),
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  // Stats overlay
                  const Positioned(
                    top: 16,
                    right: 16,
                    child: PostStatsOverlay(),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 12),
          // Secondary image - running shoes
          GestureDetector(
            onTap: () {
              // TODO: Open full-screen image viewer
            },
            child: Container(
              height: 120,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: const Color(0xFFF3F4F6),
              ),
              child: const Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.sports,
                      size: 32,
                      color: Color(0xFF6B7280),
                    ),
                    SizedBox(height: 4),
                    Text(
                      'Running Shoes',
                      style: TextStyle(
                        color: Color(0xFF6B7280),
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
