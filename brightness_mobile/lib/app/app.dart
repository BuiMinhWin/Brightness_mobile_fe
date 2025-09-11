import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:brightness_mobile/core/config/app_config.dart';
import 'package:brightness_mobile/core/theme/app_theme.dart';
import 'package:brightness_mobile/app/di.dart';
import 'package:brightness_mobile/app/router.dart';
import 'package:brightness_mobile/features/auth/presentation/controllers/login_controller.dart';
import 'package:brightness_mobile/features/onboarding/presentation/controllers/onboarding_controller.dart';
// Pages are provided via AppRouter. Remove direct imports to avoid unused warnings.
import 'package:brightness_mobile/features/home/presentation/controllers/home_controller.dart';
// import 'package:brightness_mobile/app/root_decider.dart'; // No longer used
import 'package:brightness_mobile/features/profile/presentation/controllers/edit_profile_controller.dart';
import 'package:brightness_mobile/features/profile/presentation/controllers/video_controller.dart';
import 'package:brightness_mobile/features/profile/presentation/controllers/navigation_controller.dart';
// import 'package:brightness_mobile/features/feed/feed_screen.dart'; // Routed via AppRouter

class App extends StatelessWidget {
  final AppConfig config;
  const App({super.key, required this.config});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<LoginController>(
          create: (_) => sl<LoginController>(),
        ),
        ChangeNotifierProvider<OnboardingController>(
          create: (_) => sl<OnboardingController>(),
        ),
        ChangeNotifierProvider<HomeController>(
          create: (_) => sl<HomeController>()..initialize(),
        ),
        ChangeNotifierProvider<EditProfileController>(
          create: (_) => sl<EditProfileController>(),
        ),
        ChangeNotifierProvider<VideoController>(
          create: (_) => sl<VideoController>(),
        ),
        ChangeNotifierProvider<NavigationController>(
          create: (_) => sl<NavigationController>(),
        ),
      ],
      child: MaterialApp(
        title: config.title,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: AppTheme.primaryColor),
          useMaterial3: true,
        ),
        initialRoute: AppRouter.home,
        onGenerateRoute: AppRouter.generateRoute,
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
