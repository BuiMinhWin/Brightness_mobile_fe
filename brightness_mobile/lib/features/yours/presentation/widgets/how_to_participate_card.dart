import 'dart:ui';

import 'package:brightness_mobile/features/yours/presentation/widgets/challenge_rules_section.dart';
import 'package:flutter/material.dart';

class HowToParticipateCard extends StatelessWidget {
  const HowToParticipateCard({Key? key}) : super(key: key);

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
                  color: Color(0xFF4CAF50),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.lock_open,
                  color: Colors.white,
                  size: 16,
                ),
              ),
              const SizedBox(width: 12),
              const Text(
                'How to Participate',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF333333),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          _buildParticipationStep(
            '1',
            'Complete Daily Workouts',
            'Follow the daily workout routine\n(30-45 minutes each day)',
          ),
          const SizedBox(height: 16),
          _buildParticipationStep(
            '2',
            'Track Your Progress',
            'Log your workouts, upload progress photos weekly',
          ),
          const SizedBox(height: 16),
          _buildParticipationStep(
            '3',
            'Stay Consistent',
            'Complete at least 25 out of 30 days.',
          ),
          const SizedBox(height: 20),
          const ChallengeRulesSection(),
        ],
      ),
    );
  }

  Widget _buildParticipationStep(String number, String title, String description) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 24,
          height: 24,
          decoration: BoxDecoration(
            color: const Color(0xFF2196F3),
            borderRadius: BorderRadius.circular(6),
          ),
          child: Center(
            child: Text(
              number,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 12,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
        const SizedBox(width: 12),
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
                style: const TextStyle(
                  fontSize: 14,
                  color: Color(0xFF666666),
                  height: 1.4,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}