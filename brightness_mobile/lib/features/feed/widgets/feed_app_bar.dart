import 'package:flutter/material.dart';

class FeedAppBar extends StatelessWidget implements PreferredSizeWidget {
  const FeedAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      leading: IconButton(
        icon: const Icon(
          Icons.arrow_back_ios,
          color: Color(0xFF1F2937),
        ),
        onPressed: () {
          Navigator.of(context).pop();
        },
      ),
      title: Row(
        children: [
          const Text(
            'FitNews',
            style: TextStyle(
              color: Color(0xFF1F2937),
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(width: 8),
          Container(
            padding: const EdgeInsets.all(4),
            decoration: BoxDecoration(
              color: const Color(0xFF4CAF50),
              borderRadius: BorderRadius.circular(4),
            ),
            child: const Icon(
              Icons.settings,
              color: Colors.white,
              size: 16,
            ),
          ),
        ],
      ),
      actions: [
        IconButton(
          icon: const Icon(
            Icons.search,
            color: Color(0xFF1F2937),
          ),
          onPressed: () {
            // TODO: Implement search functionality
          },
        ),
        IconButton(
          icon: Container(
            width: 24,
            height: 24,
            decoration: BoxDecoration(
              color: const Color(0xFFFF9800),
              borderRadius: BorderRadius.circular(4),
            ),
            child: const Center(
              child: Text(
                '🦊',
                style: TextStyle(fontSize: 14),
              ),
            ),
          ),
          onPressed: () {
            Navigator.of(context).pushNamed('/ai-chat');
          },
        ),
        IconButton(
          icon: const Icon(
            Icons.notifications_outlined,
            color: Color(0xFF1F2937),
          ),
          onPressed: () {
            // TODO: Navigate to notifications
          },
        ),
        const SizedBox(width: 8),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
