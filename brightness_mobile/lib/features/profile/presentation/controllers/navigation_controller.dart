import 'package:flutter/material.dart';
import '../pages/watch_video_page.dart';
import '../pages/first_aid_videos_page.dart';
import '../pages/user_profile_page.dart';
import '../pages/edit_profile_page.dart';

class NavigationController extends ChangeNotifier {
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
  
  // Navigation state
  String _currentRoute = '/';
  final List<String> _navigationHistory = [];
  
  // Getters
  String get currentRoute => _currentRoute;
  List<String> get navigationHistory => List.unmodifiable(_navigationHistory);
  
  // Navigation methods
  Future<T?> navigateTo<T extends Object?>({
    required String routeName,
    required Widget page,
    Object? arguments,
    required BuildContext context,
    bool replace = false,
  }) async {
    // Add to history
    if (!replace) {
      _navigationHistory.add(_currentRoute);
    }
    _currentRoute = routeName;
    
    notifyListeners();
    
    if (replace) {
      return Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => page,
          settings: RouteSettings(name: routeName, arguments: arguments),
        ),
      );
    } else {
      return Navigator.of(context).push<T>(
        MaterialPageRoute(
          builder: (context) => page,
          settings: RouteSettings(name: routeName, arguments: arguments),
        ),
      );
    }
  }
  
  // Specific navigation methods
  Future<void> navigateToWatchVideo({
    required String videoId,
    String? videoUrl,
    Map<String, dynamic>? videoData,
    required BuildContext context,
  }) async {
    await navigateTo(
      routeName: '/watch-video',
      arguments: {
        'videoId': videoId,
        'videoUrl': videoUrl,
        'videoData': videoData,
      },
      page: WatchVideoPage(
        videoId: videoId,
        videoUrl: videoUrl,
      ),
      context: context,
    );
  }
  
  Future<void> navigateToFirstAidVideos({required BuildContext context}) async {
    await navigateTo(
      routeName: '/first-aid-videos',
      page: const FirstAidVideosPage(),
      context: context,
    );
  }
  
  Future<void> navigateToUserProfile({
    required bool isOwnProfile,
    String? userId,
    required BuildContext context,
  }) async {
    await navigateTo(
      routeName: '/user-profile',
      arguments: {
        'isOwnProfile': isOwnProfile,
        'userId': userId,
      },
      page: UserProfilePage(isOwnProfile: isOwnProfile),
      context: context,
    );
  }
  
  Future<void> navigateToEditProfile({required BuildContext context}) async {
    await navigateTo(
      routeName: '/edit-profile',
      page: const EditProfilePage(),
      context: context,
    );
  }
  
  // Back navigation
  void goBack<T extends Object?>([T? result]) {
    final context = navigatorKey.currentContext;
    if (context == null) return;
    
    if (_navigationHistory.isNotEmpty) {
      _currentRoute = _navigationHistory.removeLast();
      notifyListeners();
    }
    
    Navigator.of(context).pop(result);
  }
  
  // Clear history
  void clearHistory() {
    _navigationHistory.clear();
    _currentRoute = '/';
    notifyListeners();
  }
  
  // Check if can go back
  bool canGoBack() {
    return _navigationHistory.isNotEmpty;
  }
}
