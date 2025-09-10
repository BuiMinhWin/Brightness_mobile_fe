import 'package:flutter/material.dart';

class FeedTabs extends StatelessWidget {
  final String selectedTab;
  final Function(String) onTabChanged;

  const FeedTabs({
    super.key,
    required this.selectedTab,
    required this.onTabChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Row(
        children: [
          _buildTab('Following', selectedTab == 'Following'),
          _buildTab('Trending', selectedTab == 'Trending'),
          _buildTab('Newest', selectedTab == 'Newest'),
        ],
      ),
    );
  }

  Widget _buildTab(String title, bool isSelected) {
    return Expanded(
      child: GestureDetector(
        onTap: () => onTabChanged(title),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 16),
          decoration: BoxDecoration(
            color: isSelected ? const Color(0xFF4CAF50) : Colors.transparent,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: isSelected ? Colors.white : const Color(0xFF6B7280),
              fontSize: 16,
              fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
            ),
          ),
        ),
      ),
    );
  }
}
