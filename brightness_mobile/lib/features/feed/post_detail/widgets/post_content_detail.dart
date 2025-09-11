import 'package:flutter/material.dart';
import '../../widgets/hashtag_text.dart';

class PostContentDetail extends StatelessWidget {
  const PostContentDetail({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Morning 10K Run - New Personal Best! 🏃‍♂️',
            style: TextStyle(
              color: Color(0xFF1F2937),
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            '2 hours ago',
            style: TextStyle(
              color: Color(0xFF6B7280),
              fontSize: 14,
            ),
          ),
          const SizedBox(height: 16),
          const HashtagText(
            text: 'Just crushed my personal record on the morning 10K! 🎉\n\nFinished in 42:36 - that\'s a 4:16/km pace! The trail was perfect this morning with cool temperatures and clear skies. Felt strong throughout the entire run and managed to negative split the last 2K.\n\nKey stats from today\'s run:\n• Distance: 10.0 km\n• Time: 42:36\n• Average Pace: 4:16/km\n• Elevation Gain: 120m\n• Average HR: 165 bpm\n\nThis has been months of consistent training paying off. The early morning runs, hill training, and tempo work are all coming together. Next goal: sub-40 for 10K by end of summer! 💪\n\n#Running #10K #PersonalBest #TrailRunning #MorningRun #Fitness #Goals',
          ),
        ],
      ),
    );
  }
}
