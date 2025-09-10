// lib/features/gamification/presentation/widgets/leaderboard_item.dart
import 'package:flutter/material.dart';
import '../../data/models/leaderboard_user.dart';

class LeaderboardItem extends StatelessWidget {
  final LeaderboardUser user;
  final int rank;

  const LeaderboardItem({
    Key? key,
    required this.user,
    required this.rank,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: Colors.grey.shade200,
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          // Rank
          Container(
            width: 32,
            height: 32,
            decoration: BoxDecoration(
              color: _getRankColor().withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Text(
                rank.toString().padLeft(2, '0'),
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: _getRankColor(),
                ),
              ),
            ),
          ),
          const SizedBox(width: 12),
          // Avatar
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  _getAvatarColors()[0],
                  _getAvatarColors()[1],
                ],
              ),
            ),
            child: Center(
              child: Text(
                user.name.substring(0, 1).toUpperCase(),
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          const SizedBox(width: 12),
          // User Info
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  user.name,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF333333),
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  '${user.points} points',
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey.shade600,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          ),
          // Trend Icon
          Container(
            width: 32,
            height: 32,
            decoration: BoxDecoration(
              color: _getTrendColor().withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(
              _getTrendIcon(),
              color: _getTrendColor(),
              size: 16,
            ),
          ),
        ],
      ),
    );
  }

  Color _getRankColor() {
    if (rank <= 3) {
      return const Color(0xFF2E7D32); // Green for top 3
    } else if (rank <= 6) {
      return const Color(0xFF4CAF50); // Medium green for 4-6
    } else {
      return const Color(0xFF8BC34A); // Light green for 7+
    }
  }

  List<Color> _getAvatarColors() {
    // Generate consistent colors based on user ID
    final colors = [
      [const Color(0xFF3182CE), const Color(0xFF4299E1)], // Blue
      [const Color(0xFF38A169), const Color(0xFF48BB78)], // Green
      [const Color(0xFF9F7AEA), const Color(0xFFB794F6)], // Purple
      [const Color(0xFFED8936), const Color(0xFFF6AD55)], // Orange
      [const Color(0xFFE53E3E), const Color(0xFFFC8181)], // Red
      [const Color(0xFF38B2AC), const Color(0xFF4FD1C7)], // Teal
    ];
    
    final index = user.id.hashCode.abs() % colors.length;
    return colors[index];
  }

  Color _getTrendColor() {
    // Simulate trend based on rank - even ranks go up, odd ranks go down
    return rank % 2 == 0 
        ? const Color(0xFF3182CE) // Blue for up trend
        : const Color(0xFFE53E3E); // Red for down trend
  }

  IconData _getTrendIcon() {
    // Simulate trend based on rank - even ranks go up, odd ranks go down
    return rank % 2 == 0 
        ? Icons.keyboard_arrow_up 
        : Icons.keyboard_arrow_down;
  }
}