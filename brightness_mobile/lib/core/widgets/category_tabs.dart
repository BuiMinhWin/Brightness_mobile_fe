import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class CategoryTabs extends StatelessWidget {
  final List<CategoryData> categories;
  final String selectedCategory;
  final Function(String) onCategorySelected;

  const CategoryTabs({
    super.key,
    required this.categories,
    required this.selectedCategory,
    required this.onCategorySelected,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: categories.length,
        itemBuilder: (context, index) {
          final category = categories[index];
          final isSelected = category.id == selectedCategory;
          
          return Padding(
            padding: const EdgeInsets.only(right: 12),
            child: _buildCategoryTab(category, isSelected),
          );
        },
      ),
    );
  }

  Widget _buildCategoryTab(CategoryData category, bool isSelected) {
    return GestureDetector(
      onTap: () => onCategorySelected(category.id),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? AppTheme.primaryColor : Colors.transparent,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isSelected ? AppTheme.primaryColor : AppTheme.borderColor,
            width: 1,
          ),
        ),
        child: Text(
          category.name,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: isSelected ? Colors.white : AppTheme.textSecondary,
          ),
        ),
      ),
    );
  }
}

class CategoryData {
  final String id;
  final String name;
  final Color? color;

  const CategoryData({
    required this.id,
    required this.name,
    this.color,
  });
}
