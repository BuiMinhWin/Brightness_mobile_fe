import 'package:flutter/material.dart';
import '../../data/models/yours.dart'; // Import the unified model

class DietPlanCard extends StatelessWidget {
  final DietPlanModel dietPlan;
  final VoidCallback onTap;

  const DietPlanCard({
    Key? key,
    required this.dietPlan,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(16),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Row(
              children: [
                _buildIcon(),
                const SizedBox(width: 16),
                _buildContent(),
                const SizedBox(width: 16),
                _buildArrow(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildIcon() {
    return Container(
      width: 48,
      height: 48,
      decoration: BoxDecoration(
        color: const Color(0xFFF1F8E9),
        borderRadius: BorderRadius.circular(12),
      ),
      child: const Icon(
        Icons.restaurant_menu,
        color: Color(0xFF4CAF50),
        size: 24,
      ),
    );
  }

  Widget _buildContent() {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            dietPlan.title,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Color(0xFF333333),
            ),
          ),
          const SizedBox(height: 12),
          _buildProgressBar(),
        ],
      ),
    );
  }

  Widget _buildProgressBar() {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: Container(
                height: 6,
                decoration: BoxDecoration(
                  color: const Color(0xFFE8F5E8),
                  borderRadius: BorderRadius.circular(3),
                ),
                child: FractionallySizedBox(
                  alignment: Alignment.centerLeft,
                  widthFactor: dietPlan.progress,
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [Color(0xFF4CAF50), Color(0xFF66BB6A)],
                      ),
                      borderRadius: BorderRadius.circular(3),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(width: 8),
            Text(
              dietPlan.progressPercentage,
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey.shade600,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildArrow() {
    return Icon(
      Icons.chevron_right,
      color: Colors.grey.shade400,
      size: 24,
    );
  }
}