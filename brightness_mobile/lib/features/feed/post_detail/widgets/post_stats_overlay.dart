import 'package:flutter/material.dart';

class PostStatsOverlay extends StatelessWidget {
  const PostStatsOverlay({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white.withAlpha(242),
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(26),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text(
            '8:76',
            style: TextStyle(
              color: Color(0xFF1F2937),
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 4),
          const Text(
            'Pace (min/km)',
            style: TextStyle(
              color: Color(0xFF6B7280),
              fontSize: 12,
            ),
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildStatItem('10.0', 'km'),
              const SizedBox(width: 12),
              _buildStatItem('165', 'bpm'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatItem(String value, String unit) {
    return Column(
      children: [
        Text(
          value,
          style: const TextStyle(
            color: Color(0xFF1F2937),
            fontSize: 14,
            fontWeight: FontWeight.w600,
          ),
        ),
        Text(
          unit,
          style: const TextStyle(
            color: Color(0xFF6B7280),
            fontSize: 10,
          ),
        ),
      ],
    );
  }
}
