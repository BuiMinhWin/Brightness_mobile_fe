import 'package:flutter/material.dart';
import '../../features/yours/presentation/pages/home_page_content.dart';
import '../../features/yours/presentation/pages/event_page_content.dart';
import '../../features/yours/presentation/pages/yours_page_content.dart';
import '../../features/yours/presentation/pages/video_page_content.dart';
import '../../features/yours/presentation/pages/leaderboard_page_content.dart';
import '../../shared/widgets/custom_bottom_navbar.dart';

class MainNavigationController extends StatefulWidget {
  const MainNavigationController({Key? key}) : super(key: key);

  @override
  State<MainNavigationController> createState() => _MainNavigationControllerState();
}

class _MainNavigationControllerState extends State<MainNavigationController> {
  int _currentIndex = 2; // Start with Yours page
  
  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: _currentIndex);
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
    _pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _pageController,
        onPageChanged: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
       children: [
        const HomePageContent(key: ValueKey('Home')),
        const EventPageContent(key: ValueKey('Event')),
        const YoursPageContent(key: ValueKey('Yours')),
        const VideoPageContent(key: ValueKey('Video')),
        const LeaderboardPageContent(key: ValueKey('Leaderboard')),
      ],
      ),
      bottomNavigationBar: CustomBottomNavBar(
        currentIndex: _currentIndex,
        onTap: _onTabTapped,
      ),
    );
  }
}