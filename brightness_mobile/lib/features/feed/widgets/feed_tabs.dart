import 'package:flutter/material.dart';
import '../../../core/theme/app_theme.dart';

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
          height: 48, // Fixed height for consistent tab size
          margin: const EdgeInsets.symmetric(
            horizontal: 4,
          ), // Space between tabs
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
          decoration: BoxDecoration(
            color: isSelected ? AppTheme.feedBarColor : Colors.transparent,
            borderRadius: BorderRadius.circular(100), // More balanced radius
          ),
          child: Center(
            // Ensures perfect centering
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
      ),
    );
  }
}
