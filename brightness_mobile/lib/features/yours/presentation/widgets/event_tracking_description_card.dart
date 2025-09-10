import 'package:brightness_mobile/features/yours/data/models/yours.dart';
import 'package:flutter/material.dart';

class EventTrackingDescriptionCard extends StatelessWidget {
  final DietPlanModel dietPlan;

  const EventTrackingDescriptionCard({
    Key? key,
    required this.dietPlan,
  }) : super(key: key);

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
                  color: Color(0xFF2196F3),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.info,
                  color: Colors.white,
                  size: 16,
                ),
              ),
              const SizedBox(width: 12),
              const Text(
                'Event Description',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF333333),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Text(
            'Join thousands of fitness enthusiasts in our most exciting 30-day challenge yet! This comprehensive program combines strength training, cardio workouts, and mindfulness practices to help you achieve your fitness goals. Whether you\'re a beginner or an experienced athlete, this challenge adapts to your fitness level and pushes you to new heights.',
            style: const TextStyle(
              fontSize: 14,
              color: Color(0xFF666666),
              height: 1.5,
            ),
          ),
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: const Color(0xFFF1F8E9),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.trending_up,
                  color: dietPlan.progressColor,
                  size: 20,
                ),
                const SizedBox(width: 8),
                Text(
                  'Current Progress: ${dietPlan.progressPercentage}',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: dietPlan.progressColor,
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
