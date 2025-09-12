import 'package:flutter/material.dart';

class CreatePostHeader extends StatelessWidget implements PreferredSizeWidget {
  const CreatePostHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back, color: Color(0xFF1F2937)),
        onPressed: () {
          Navigator.of(context).pop();
        },
      ),
      title: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image(
            image: AssetImage('assets/images/logo b&w-07.png'),
            width: 24,
            height: 24,
          ),
          const SizedBox(width: 8),
          Text(
            'Create Post',
            style: TextStyle(
              color: Color(0xFF1F2937),
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(width: 8),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () {
            _showCancelDialog(context);
          },
          child: const Text(
            'Cancel',
            style: TextStyle(color: Color(0xFF6B7280), fontSize: 16),
          ),
        ),
        const SizedBox(width: 8),
      ],
    );
  }

  void _showCancelDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Discard Post?'),
        content: const Text(
          'Are you sure you want to discard this post? Your changes will be lost.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Keep Editing'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              Navigator.of(context).pop();
            },
            child: const Text('Discard', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
