import 'package:flutter/material.dart';
import '../features/feed/feed_screen.dart';
import '../features/feed/post_detail_screen.dart';
import '../features/feed/create_post_screen.dart';
import '../features/ai_chat/ai_chat_screen.dart';
import '../features/profile/presentation/pages/profile_demo_page.dart';

class AppRouter {
  static const String feed = '/feed';
  static const String profile = '/profile';
  static const String postDetail = '/post-detail';
  static const String createPost = '/create-post';
  static const String aiChat = '/ai-chat';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case feed:
        return MaterialPageRoute(
          builder: (_) => const FeedScreen(),
          settings: settings,
        );
      case profile:
        return MaterialPageRoute(
          builder: (_) => const ProfileDemoPage(),
          settings: settings,
        );
      case postDetail:
        final args = settings.arguments as Map<String, dynamic>?;
        return MaterialPageRoute(
          builder: (_) => PostDetailScreen(
            postId: args?['postId'] ?? '',
            postData: args?['postData'],
          ),
          settings: settings,
        );
      case createPost:
        return MaterialPageRoute(
          builder: (_) => const CreatePostScreen(),
          settings: settings,
        );
      case aiChat:
        return MaterialPageRoute(
          builder: (_) => const AiChatScreen(),
          settings: settings,
        );
      default:
        return MaterialPageRoute(
          builder: (_) => const FeedScreen(),
          settings: settings,
        );
    }
  }
}

