import 'package:flutter/material.dart';

class FormattingToolbar extends StatelessWidget {
  final bool isBold;
  final bool isItalic;
  final bool isBulletList;
  final bool isNumberedList;
  final Function({
    bool? bold,
    bool? italic,
    bool? bulletList,
    bool? numberedList,
  }) onFormattingChanged;

  const FormattingToolbar({
    super.key,
    required this.isBold,
    required this.isItalic,
    required this.isBulletList,
    required this.isNumberedList,
    required this.onFormattingChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: const Color(0xFFF9FAFB),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: const Color(0xFFE5E7EB),
        ),
      ),
      child: Row(
        children: [
          _buildFormatButton(
            icon: Icons.format_bold,
            isActive: isBold,
            onPressed: () => onFormattingChanged(bold: !isBold),
          ),
          const SizedBox(width: 8),
          _buildFormatButton(
            icon: Icons.format_italic,
            isActive: isItalic,
            onPressed: () => onFormattingChanged(italic: !isItalic),
          ),
          const SizedBox(width: 8),
          _buildFormatButton(
            icon: Icons.format_list_bulleted,
            isActive: isBulletList,
            onPressed: () => onFormattingChanged(bulletList: !isBulletList),
          ),
          const SizedBox(width: 8),
          _buildFormatButton(
            icon: Icons.format_list_numbered,
            isActive: isNumberedList,
            onPressed: () => onFormattingChanged(numberedList: !isNumberedList),
          ),
          const SizedBox(width: 8),
          _buildFormatButton(
            icon: Icons.link,
            isActive: false,
            onPressed: () {
              // TODO: Implement link functionality
            },
          ),
          const Spacer(),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: const Color(0xFFFF9800),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(
                  Icons.auto_awesome,
                  color: Colors.white,
                  size: 16,
                ),
                const SizedBox(width: 4),
                const Text(
                  'AI Edit',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFormatButton({
    required IconData icon,
    required bool isActive,
    required VoidCallback onPressed,
  }) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: 32,
        height: 32,
        decoration: BoxDecoration(
          color: isActive ? const Color(0xFF4CAF50) : Colors.transparent,
          borderRadius: BorderRadius.circular(6),
        ),
        child: Icon(
          icon,
          color: isActive ? Colors.white : const Color(0xFF6B7280),
          size: 18,
        ),
      ),
    );
  }
}
