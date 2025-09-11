import 'package:flutter/material.dart';

class RichTextEditor extends StatelessWidget {
  final TextEditingController controller;
  final bool isBold;
  final bool isItalic;
  final bool isBulletList;
  final bool isNumberedList;

  const RichTextEditor({
    super.key,
    required this.controller,
    this.isBold = false,
    this.isItalic = false,
    this.isBulletList = false,
    this.isNumberedList = false,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Content',
          style: TextStyle(
            color: Color(0xFF1F2937),
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 8),
        Container(
          decoration: BoxDecoration(
            border: Border.all(
              color: const Color(0xFFE5E7EB),
            ),
            borderRadius: BorderRadius.circular(8),
          ),
          child: TextField(
            controller: controller,
            maxLines: 8,
            maxLength: 2000,
            style: TextStyle(
              color: const Color(0xFF1F2937),
              fontSize: 16,
              fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
              fontStyle: isItalic ? FontStyle.italic : FontStyle.normal,
            ),
            decoration: const InputDecoration(
              hintText: 'Share your fitness journey, workout tips, or nutrition advice...',
              hintStyle: TextStyle(
                color: Color(0xFF9CA3AF),
                fontSize: 16,
              ),
              border: InputBorder.none,
              contentPadding: EdgeInsets.all(16),
              counterStyle: TextStyle(
                color: Color(0xFF6B7280),
                fontSize: 12,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
