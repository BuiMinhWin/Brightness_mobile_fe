import 'package:flutter/material.dart';

class EventDurationCard extends StatelessWidget {
  const EventDurationCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 24,
                height: 24,
                decoration: const BoxDecoration(
                  color: Color(0xFF9C27B0),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.calendar_today,
                  color: Colors.white,
                  size: 16,
                ),
              ),
              const SizedBox(width: 12),
              const Text(
                'Event Duration',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF333333),
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          Row(
            children: [
              Expanded(
                child: Column(
                  children: [
                    const Text(
                      '30',
                      style: TextStyle(
                        fontSize: 48,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF333333),
                        height: 1.0,
                      ),
                    ),
                    Text(
                      'Days Total',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey.shade600,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                width: 1,
                height: 60,
                color: Colors.grey.shade300,
              ),
              Expanded(
                child: Column(
                  children: [
                    const Text(
                      '45',
                      style: TextStyle(
                        fontSize: 48,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF333333),
                        height: 1.0,
                      ),
                    ),
                    Text(
                      'Min/Day',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey.shade600,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          _buildDateInfo('Start Date:', 'March 1, 2024'),
          const SizedBox(height: 8),
          _buildDateInfo('End Date:', 'March 30, 2024'),
        ],
      ),
    );
  }

  Widget _buildDateInfo(String label, String date) {
    return Row(
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 14,
            color: Colors.grey.shade600,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(width: 8),
        Text(
          date,
          style: const TextStyle(
            fontSize: 14,
            color: Color(0xFF333333),
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}

// 5. Rewards and Prizes Card - Reusable Component
class RewardsAndPrizesCard extends StatelessWidget {
  const RewardsAndPrizesCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 24,
                height: 24,
                decoration: const BoxDecoration(
                  color: Color(0xFFFF9800),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.emoji_events,
                  color: Colors.white,
                  size: 16,
                ),
              ),
              const SizedBox(width: 12),
              const Text(
                'Rewards & Prizes',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF333333),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          _buildPrizeItem(
            Icons.emoji_events,
            'Grand Prize Winner',
            '\$300 in cash',
            const Color(0xFFFFD700),
            const Color(0xFFFFF3C4),
          ),
          const SizedBox(height: 16),
          _buildPrizeItem(
            Icons.military_tech,
            'Top 10 Finishers',
            'Premium workout gear',
            const Color(0xFFFF7043),
            const Color(0xFFFFF3E0),
          ),
          const SizedBox(height: 16),
          _buildPrizeItem(
            Icons.stars,
            'All Completers',
            'Digital badge & certificate',
            const Color(0xFF2196F3),
            const Color(0xFFE3F2FD),
          ),
        ],
      ),
    );
  }

  Widget _buildPrizeItem(IconData icon, String title, String description, Color iconColor, Color bgColor) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: iconColor.withOpacity(0.3),
          width: 1,
        ),
      ),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: iconColor,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(
              icon,
              color: Colors.white,
              size: 20,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF333333),
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  description,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey.shade600,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}