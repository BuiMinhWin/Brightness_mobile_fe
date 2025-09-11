import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:brightness_mobile/core/config/app_config.dart';
import 'package:brightness_mobile/core/theme/app_theme.dart';
import 'package:brightness_mobile/app/di.dart';
import 'package:brightness_mobile/app/router.dart';
import 'package:brightness_mobile/features/auth/presentation/controllers/login_controller.dart';
import 'package:brightness_mobile/features/onboarding/presentation/controllers/onboarding_controller.dart';
import 'package:brightness_mobile/features/onboarding/presentation/pages/onboarding_page.dart';
import 'package:brightness_mobile/features/home/presentation/pages/home_page.dart';
import 'package:brightness_mobile/features/home/presentation/pages/steps_detail_page.dart';
import 'package:brightness_mobile/features/home/presentation/pages/calendar_page.dart';
import 'package:brightness_mobile/features/settings/presentation/pages/settings_page.dart';
import 'package:brightness_mobile/features/home/presentation/controllers/home_controller.dart';
import 'package:brightness_mobile/features/run/presentation/pages/run_map_page.dart';
import 'package:brightness_mobile/features/run/presentation/pages/run_detail_page.dart';
import 'package:brightness_mobile/features/workout/presentation/pages/workout_page.dart';

import 'package:brightness_mobile/app/root_decider.dart';
import 'package:brightness_mobile/features/profile/presentation/controllers/edit_profile_controller.dart';
import 'package:brightness_mobile/features/profile/presentation/controllers/video_controller.dart';
import 'package:brightness_mobile/features/profile/presentation/controllers/navigation_controller.dart';
import 'package:brightness_mobile/features/feed/feed_screen.dart';

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
        home: const LoginPage(),
      ),
    );
  }
}
