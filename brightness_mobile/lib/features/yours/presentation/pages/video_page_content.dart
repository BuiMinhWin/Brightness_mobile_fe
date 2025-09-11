
import 'package:flutter/material.dart';

class VideoPageContent extends StatelessWidget {
  const VideoPageContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Color(0xFF2E7D32), // Dark green
            Color(0xFF4CAF50), // Medium green
            Color(0xFF8BC34A), // Light green
            Color(0xFFCDDC39), // Yellow green
          ],
        ),
      ),
      child: const SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.videocam,
                size: 80,
                color: Colors.white,
              ),
              SizedBox(height: 20),
              Text(
                'Video',
                style: TextStyle(
                  fontSize: 36,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 10),
              Text(
                'Video content will be here',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.white70,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}