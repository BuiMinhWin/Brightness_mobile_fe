import 'package:brightness_mobile/features/home/presentation/pages/home_page.dart';
import 'package:brightness_mobile/features/profile/presentation/pages/first_aid_videos_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../features/yours/presentation/pages/event_page_content.dart';
import '../../features/yours/presentation/pages/yours_page_content.dart';
import '../../features/yours/presentation/pages/leaderboard_page_content.dart';
import '../../shared/widgets/custom_bottom_navbar.dart';
import '../../features/profile/presentation/controllers/navigation_controller.dart';
import '../../features/profile/presentation/controllers/video_controller.dart';
import '../../features/profile/presentation/controllers/edit_profile_controller.dart';
import '../../app/di.dart' as di;

class MainNavigationController extends StatefulWidget {
  const MainNavigationController({super.key});

  @override
  State<MainNavigationController> createState() =>
      _MainNavigationControllerState();
}

class _MainNavigationControllerState extends State<MainNavigationController> {
  int _currentIndex = 2; // Start with Yours page
  bool _showBottomNavBar = true; // Control navbar visibility

  late PageController _pageController;
  late Widget _pageView;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: 1); // Yours page = index 1

    _pageView = PageView(
      controller: _pageController,
      onPageChanged: _onPageChanged,
      physics: const ClampingScrollPhysics(),
      children: const [
        EventPageContent(key: ValueKey('EventPage')),
        YoursPageContent(key: ValueKey('YoursPage')),
        LeaderboardPageContent(key: ValueKey('LeaderboardPage')),
      ],
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });

    if (index == 0) {
      // Navigate to Home page without navbar
      setState(() {
        _showBottomNavBar = false;
      });
      return;
    }

    if (index == 3) {
      // Navigate to Video page without navbar
      setState(() {
        _showBottomNavBar = false;
      });
      return;
    }

    // Handle PageView navigation for Event, Yours, and Leaderboard
    setState(() {
      _showBottomNavBar = true;
    });

    int pageIndex;
    switch (index) {
      case 1: // Event
        pageIndex = 0;
      case 2: // Yours
        pageIndex = 1;
      case 4: // Leaderboard
        pageIndex = 2;
      default:
        pageIndex = 1;
    }

    // Animate to the correct page
    if (_pageController.hasClients) {
      _pageController.animateToPage(
        pageIndex,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  void _onPageChanged(int pageIndex) {
    if (!_showBottomNavBar) return; // Don't update if navbar is hidden

    int navIndex;
    switch (pageIndex) {
      case 0:
        navIndex = 1; // Event page
      case 1:
        navIndex = 2; // Yours page
      case 2:
        navIndex = 4; // Leaderboard page
      default:
        navIndex = 2; // Default to Yours page
    }

    if (mounted) {
      setState(() {
        _currentIndex = navIndex;
      });
    }
  }

  Widget _buildCurrentPage() {
    // Show Home screen
    if (_currentIndex == 0) {
      return MultiProvider(
        providers: [
          ChangeNotifierProvider<NavigationController>(
            create: (_) => di.sl<NavigationController>(),
          ),
          ChangeNotifierProvider<VideoController>(
            create: (_) => di.sl<VideoController>(),
          ),
          ChangeNotifierProvider<EditProfileController>(
            create: (_) => di.sl<EditProfileController>(),
          ),
        ],
        child: const HomeScreen(),
      );
    }

    // Show Video screen
    if (_currentIndex == 3) {
      return MultiProvider(
        providers: [
          ChangeNotifierProvider<VideoController>(
            create: (_) => di.sl<VideoController>(),
          ),
          ChangeNotifierProvider<EditProfileController>(
            create: (_) => di.sl<EditProfileController>(),
          ),
          ChangeNotifierProvider<NavigationController>.value(
            value: Provider.of<NavigationController>(context, listen: false),
          ),
        ],
        child: const FirstAidVideosPage(),
      );
    }

    return _pageView;
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<NavigationController>(
          create: (_) => di.sl<NavigationController>(),
        ),
        ChangeNotifierProvider<VideoController>(
          create: (_) => di.sl<VideoController>(),
        ),
        ChangeNotifierProvider<EditProfileController>(
          create: (_) => di.sl<EditProfileController>(),
        ),
      ],
      child: WillPopScope(
        onWillPop: () async {
          // Handle back button
          if (!_showBottomNavBar) {
            // If navbar is hidden (Home or Video page), go back to Yours page
            _onTabTapped(2);
            return false;
          } else if (_currentIndex != 2) {
            // If navbar is shown but not on Yours page, go to Yours page
            _onTabTapped(2);
            return false;
          }
          // If on Yours page with navbar, allow normal back navigation
          return true;
        },
        child: Scaffold(
          body: _buildCurrentPage(),
          bottomNavigationBar: _showBottomNavBar
              ? CustomBottomNavBar(
                  currentIndex: _currentIndex,
                  onTap: _onTabTapped,
                )
              : null,
        ),
      ),
    );
  }
}
