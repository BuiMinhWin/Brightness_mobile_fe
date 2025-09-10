import 'package:flutter/material.dart';

class PostDetailHeader extends StatelessWidget implements PreferredSizeWidget {
  const PostDetailHeader({super.key});

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
            'Post',
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
            Icons.more_horiz,
            color: Color(0xFF1F2937),
          ),
          onPressed: () {
            _showPostOptions(context);
          },
        ),
        const SizedBox(width: 8),
      ],
    );
  }

  void _showPostOptions(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) => Container(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.share, color: Color(0xFF4CAF50)),
              title: const Text('Share Post'),
              onTap: () {
                Navigator.pop(context);
                // TODO: Implement share functionality
              },
            ),
            ListTile(
              leading: const Icon(Icons.copy, color: Colors.blue),
              title: const Text('Copy Link'),
              onTap: () {
                Navigator.pop(context);
                // TODO: Implement copy link functionality
              },
            ),
            ListTile(
              leading: const Icon(Icons.report, color: Colors.red),
              title: const Text('Report Post'),
              onTap: () {
                Navigator.pop(context);
                // TODO: Implement report functionality
              },
            ),
            ListTile(
              leading: const Icon(Icons.block, color: Colors.orange),
              title: const Text('Block User'),
              onTap: () {
                Navigator.pop(context);
                // TODO: Implement block functionality
              },
            ),
          ],
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
