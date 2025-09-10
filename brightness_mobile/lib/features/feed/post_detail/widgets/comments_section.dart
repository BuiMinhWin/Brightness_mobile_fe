import 'package:flutter/material.dart';
import 'comment_card.dart';

class CommentsSection extends StatelessWidget {
  const CommentsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Comments',
            style: TextStyle(
              color: Color(0xFF1F2937),
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          ..._getSampleComments().map((comment) => CommentCard(
            username: comment['username'],
            comment: comment['comment'],
            timestamp: comment['timestamp'],
            likes: comment['likes'],
            isLiked: comment['isLiked'],
            replies: comment['replies'],
          )),
        ],
      ),
    );
  }

  List<Map<String, dynamic>> _getSampleComments() {
    return [
      {
        'username': 'Sarah Chen',
        'comment': 'Amazing pace! 🔥 What\'s your training schedule like?',
        'timestamp': '1h',
        'likes': 8,
        'isLiked': false,
        'replies': [],
      },
      {
        'username': 'Mike Rodriguez',
        'comment': 'Congrats on the PR! 🎉 That trail looks beautiful',
        'timestamp': '45m',
        'likes': 5,
        'isLiked': true,
        'replies': [],
      },
      {
        'username': 'Emma Wilson',
        'comment': 'Sub-43 for 10K is incredible! 💪 Any tips for pacing?',
        'timestamp': '30m',
        'likes': 12,
        'isLiked': false,
        'replies': [
          {
            'username': 'Alex Thompson',
            'comment': 'Thanks Emma! Start conservative and build up gradually 👍',
            'timestamp': '25m',
            'likes': 3,
            'isLiked': false,
          },
        ],
      },
    ];
  }
}
