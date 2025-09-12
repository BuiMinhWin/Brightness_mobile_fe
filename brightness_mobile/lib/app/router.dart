import 'package:brightness_mobile/features/profile/presentation/pages/user_profile_page.dart';
import 'package:flutter/material.dart';

// Core app pages
import '../features/auth/presentation/pages/login_page.dart';
import '../features/auth/presentation/pages/register_page.dart';
import '../features/onboarding/presentation/pages/onboarding_page.dart';
import '../features/home/presentation/pages/home_page.dart';
import '../features/home/presentation/pages/steps_detail_page.dart';
import '../features/home/presentation/pages/calendar_page.dart';
import '../features/settings/presentation/pages/settings_page.dart';
import '../features/run/presentation/pages/run_map_page.dart';
import '../features/run/presentation/pages/run_detail_page.dart';
import '../features/workout/presentation/pages/workout_page.dart';
import '../features/pricing/presentation/pages/pricing_page.dart';

// Feed and misc
import '../features/feed/feed_screen.dart';
import '../features/feed/post_detail_screen.dart';
import '../features/feed/create_post_screen.dart';
import '../features/ai_chat/ai_chat_screen.dart';
// import '../features/profile/presentation/pages/profile_demo_page.dart';
import '../core/navigation/main_navigation_controller.dart';

class AppRouter {
  // Main
  static const String home = '/home';
  static const String login = '/login';
  static const String register = '/register';
  static const String onboarding = '/onboarding';
  static const String main = '/main';
  static const String pricing = '/pricing';

  // Home sub-pages
  static const String stepsDetail = '/home/detail';
  static const String calendar = '/home/calendar';
  static const String settingsPage = '/settings';
  static const String runMap = '/map/map';
  static const String runDetail = '/map/detail';
  static const String workout = '/workout/calendar';

  // Feed
  static const String feed = '/feed';
  static const String profile = '/profile';
  static const String postDetail = '/post-detail';
  static const String createPost = '/create-post';
  static const String aiChat = '/ai-chat';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      // Main
      case home:
        return MaterialPageRoute(
          builder: (_) => const HomeScreen(),
          settings: settings,
        );
      case login:
        return MaterialPageRoute(
          builder: (_) => const LoginPage(),
          settings: settings,
        );
      case register:
        return MaterialPageRoute(
          builder: (_) => const RegisterPage(),
          settings: settings,
        );
      case main:
        return MaterialPageRoute(
          builder: (_) => const MainNavigationController(),
          settings: settings,
        );
      case pricing:
        return MaterialPageRoute(
          builder: (_) => const PricingPage(),
          settings: settings,
        );
      case onboarding:
        return MaterialPageRoute(
          builder: (_) => const OnboardingScreen(),
          settings: settings,
        );

      // Home sub-pages
      case stepsDetail:
        return MaterialPageRoute(
          builder: (_) => const StepsDetailPage(),
          settings: settings,
        );
      case calendar:
        return MaterialPageRoute(
          builder: (_) => const CalendarPage(),
          settings: settings,
        );
      case settingsPage:
        return MaterialPageRoute(
          builder: (_) => const SettingsPage(),
          settings: settings,
        );
      case runMap:
        return MaterialPageRoute(
          builder: (_) => const RunMapPage(),
          settings: settings,
        );
      case runDetail:
        return MaterialPageRoute(
          builder: (_) => const RunDetailPage(),
          settings: settings,
        );
      case workout:
        return MaterialPageRoute(
          builder: (_) => const WorkoutPage(),
          settings: settings,
        );

      // Feed
      case feed:
        return MaterialPageRoute(
          builder: (_) => const FeedScreen(),
          settings: settings,
        );
      case profile:
        return MaterialPageRoute(
          builder: (_) => const UserProfilePage(isOwnProfile: true),
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
          builder: (_) => const HomeScreen(),
          settings: settings,
        );
    }
  }
}
