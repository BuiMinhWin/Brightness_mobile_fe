import 'package:flutter/material.dart';

class PostTitleInput extends StatelessWidget {
  final TextEditingController controller;

  const PostTitleInput({
    super.key,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Title',
          style: TextStyle(
            color: Color(0xFF1F2937),
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 8),
        TextField(
          controller: controller,
          autofocus: true,
          maxLength: 100,
          style: const TextStyle(
            color: Color(0xFF1F2937),
            fontSize: 18,
            fontWeight: FontWeight.w500,
          ),
          decoration: const InputDecoration(
            hintText: 'My 5-Day HIIT Routine',
            hintStyle: TextStyle(
              color: Color(0xFF9CA3AF),
              fontSize: 18,
              fontWeight: FontWeight.w400,
            ),
            border: InputBorder.none,
            counterStyle: TextStyle(
              color: Color(0xFF6B7280),
              fontSize: 12,
            ),
            contentPadding: EdgeInsets.zero,
          ),
        ),
        const Divider(
          color: Color(0xFFE5E7EB),
          thickness: 1,
        ),
      ],
    );
  }
}
