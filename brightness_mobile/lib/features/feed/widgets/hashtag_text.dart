import 'package:flutter/material.dart';

class HashtagText extends StatelessWidget {
  final String text;
  final Function(String)? onHashtagTap;

  const HashtagText({
    super.key,
    required this.text,
    this.onHashtagTap,
  });

  @override
  Widget build(BuildContext context) {
    final words = text.split(' ');
    final List<TextSpan> spans = [];

    for (String word in words) {
      if (word.startsWith('#')) {
        spans.add(
          TextSpan(
            text: '$word ',
            style: TextStyle(
              color: _getHashtagColor(word.toLowerCase()),
              fontWeight: FontWeight.w600,
              fontSize: 16,
            ),
          ),
        );
      } else {
        spans.add(
          TextSpan(
            text: '$word ',
            style: const TextStyle(
              color: Color(0xFF1F2937),
              fontSize: 16,
            ),
          ),
        );
      }
    }

    return RichText(
      text: TextSpan(children: spans),
    );
  }

  Color _getHashtagColor(String hashtag) {
    // Fitness hashtags - Blue
    if (hashtag.contains('#workout') ||
        hashtag.contains('#fitness') ||
        hashtag.contains('#gym') ||
        hashtag.contains('#training') ||
        hashtag.contains('#motivation')) {
      return const Color(0xFF2196F3);
    }
    
    // Nutrition hashtags - Green
    if (hashtag.contains('#mealprep') ||
        hashtag.contains('#healthy') ||
        hashtag.contains('#nutrition') ||
        hashtag.contains('#eating') ||
        hashtag.contains('#diet')) {
      return const Color(0xFF4CAF50);
    }
    
    // Running hashtags - Orange
    if (hashtag.contains('#running') ||
        hashtag.contains('#run') ||
        hashtag.contains('#cardio') ||
        hashtag.contains('#marathon') ||
        hashtag.contains('#personalrecord')) {
      return const Color(0xFFFF9800);
    }
    
    // Yoga hashtags - Purple
    if (hashtag.contains('#yoga') ||
        hashtag.contains('#mindfulness') ||
        hashtag.contains('#meditation') ||
        hashtag.contains('#flexibility') ||
        hashtag.contains('#outdoorworkout')) {
      return const Color(0xFF9C27B0);
    }
    
    // Default color for other hashtags
    return const Color(0xFF6B7280);
  }
}
