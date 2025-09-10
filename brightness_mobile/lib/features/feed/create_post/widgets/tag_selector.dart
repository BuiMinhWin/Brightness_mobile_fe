import 'package:flutter/material.dart';

class TagSelector extends StatelessWidget {
  final List<String> selectedTags;
  final Function(List<String>) onTagsChanged;

  const TagSelector({
    super.key,
    required this.selectedTags,
    required this.onTagsChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Add Tags',
          style: TextStyle(
            color: Color(0xFF1F2937),
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 12),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: [
            ..._getAvailableTags().map((tag) => _buildTagChip(tag)),
            _buildAddTagButton(),
          ],
        ),
      ],
    );
  }

  Widget _buildTagChip(Map<String, dynamic> tag) {
    final isSelected = selectedTags.contains(tag['name']);
    
    return GestureDetector(
      onTap: () {
        final newTags = List<String>.from(selectedTags);
        if (isSelected) {
          newTags.remove(tag['name']);
        } else {
          newTags.add(tag['name']);
        }
        onTagsChanged(newTags);
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          color: isSelected ? tag['color'] : Colors.transparent,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: tag['color'],
            width: 1,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              tag['name'],
              style: TextStyle(
                color: isSelected ? Colors.white : tag['color'],
                fontSize: 12,
                fontWeight: FontWeight.w500,
              ),
            ),
            if (isSelected) ...[
              const SizedBox(width: 4),
              const Icon(
                Icons.close,
                color: Colors.white,
                size: 14,
              ),
            ] else ...[
              const SizedBox(width: 4),
              Icon(
                Icons.add,
                color: tag['color'],
                size: 14,
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildAddTagButton() {
    return GestureDetector(
      onTap: () {
        _showAddCustomTagDialog();
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          color: const Color(0xFFF3F4F6),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: const Color(0xFFD1D5DB),
            width: 1,
          ),
        ),
        child: const Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Custom',
              style: TextStyle(
                color: Color(0xFF6B7280),
                fontSize: 12,
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(width: 4),
            Icon(
              Icons.add,
              color: Color(0xFF6B7280),
              size: 14,
            ),
          ],
        ),
      ),
    );
  }

  List<Map<String, dynamic>> _getAvailableTags() {
    return [
      {
        'name': 'Workout',
        'color': const Color(0xFFFF9800),
      },
      {
        'name': 'Nutrition',
        'color': const Color(0xFF4CAF50),
      },
      {
        'name': 'Injury',
        'color': const Color(0xFF2196F3),
      },
      {
        'name': 'Motivation',
        'color': const Color(0xFF9C27B0),
      },
    ];
  }

  void _showAddCustomTagDialog() {
    // TODO: Implement custom tag dialog
  }
}
