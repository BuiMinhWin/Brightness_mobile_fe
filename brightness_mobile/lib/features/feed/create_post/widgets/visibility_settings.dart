import 'package:flutter/material.dart';

class VisibilitySettings extends StatelessWidget {
  final bool isPublic;
  final Function(bool) onVisibilityChanged;

  const VisibilitySettings({
    super.key,
    required this.isPublic,
    required this.onVisibilityChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Visibility',
          style: TextStyle(
            color: Color(0xFF1F2937),
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 8),
        const Text(
          'Who can see this post?',
          style: TextStyle(
            color: Color(0xFF6B7280),
            fontSize: 14,
          ),
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(
              child: _buildVisibilityOption(
                title: 'Public',
                subtitle: 'Everyone can see',
                icon: Icons.public,
                isSelected: isPublic,
                onTap: () => onVisibilityChanged(true),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _buildVisibilityOption(
                title: 'Private',
                subtitle: 'Only you',
                icon: Icons.lock,
                isSelected: !isPublic,
                onTap: () => onVisibilityChanged(false),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildVisibilityOption({
    required String title,
    required String subtitle,
    required IconData icon,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFF4CAF50).withOpacity(0.1) : Colors.transparent,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected ? const Color(0xFF4CAF50) : const Color(0xFFE5E7EB),
            width: 2,
          ),
        ),
        child: Column(
          children: [
            Icon(
              icon,
              color: isSelected ? const Color(0xFF4CAF50) : const Color(0xFF6B7280),
              size: 24,
            ),
            const SizedBox(height: 8),
            Text(
              title,
              style: TextStyle(
                color: isSelected ? const Color(0xFF4CAF50) : const Color(0xFF1F2937),
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 2),
            Text(
              subtitle,
              style: const TextStyle(
                color: Color(0xFF6B7280),
                fontSize: 12,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
