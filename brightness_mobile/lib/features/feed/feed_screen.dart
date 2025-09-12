import 'package:flutter/material.dart';
import '../feed/widgets/feed_app_bar.dart';
import '../feed/widgets/feed_tabs.dart';
import '../feed/widgets/social_feed.dart';

class FeedScreen extends StatefulWidget {
  const FeedScreen({super.key});

  @override
  State<FeedScreen> createState() => _FeedScreenState();
}

class _FeedScreenState extends State<FeedScreen> {
  String _selectedTab = 'Following';

  void _onTabChanged(String tab) {
    setState(() {
      _selectedTab = tab;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const FeedAppBar(),
      body: Column(
        children: [
          FeedTabs(selectedTab: _selectedTab, onTabChanged: _onTabChanged),
          Expanded(child: SocialFeed(selectedTab: _selectedTab)),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).pushNamed('/create-post');
        },
        backgroundColor: const Color(0xFF4CAF50),
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}
