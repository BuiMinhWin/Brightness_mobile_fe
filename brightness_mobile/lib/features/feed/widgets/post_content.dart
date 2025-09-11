import 'package:flutter/material.dart';
import 'hashtag_text.dart';

class PostContent extends StatelessWidget {
  final String content;

  const PostContent({
    super.key,
    required this.content,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: HashtagText(text: content),
    );
  }
}
