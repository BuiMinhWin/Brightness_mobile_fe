import 'package:flutter/material.dart';

class ChallengeRulesSection extends StatelessWidget {
  const ChallengeRulesSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFFFF3C4),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: const Color(0xFFFF9800),
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(
                Icons.warning_amber,
                color: Color(0xFFFF9800),
                size: 16,
              ),
              const SizedBox(width: 8),
              const Text(
                'Challenge Rules',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFFFF9800),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          _buildRuleItem('No skipping more than 5 consecutive days'),
          _buildRuleItem('Must complete minimum 80% of each workout'),
          _buildRuleItem('Progress photos required weekly for verification'),
          _buildRuleItem('Follow community guidelines and support others'),
        ],
      ),
    );
  }

  Widget _buildRuleItem(String rule) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 4,
            height: 4,
            margin: const EdgeInsets.only(top: 6),
            decoration: const BoxDecoration(
              color: Color(0xFFFF9800),
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              rule,
              style: const TextStyle(
                fontSize: 12,
                color: Color(0xFFFF9800),
                height: 1.4,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
