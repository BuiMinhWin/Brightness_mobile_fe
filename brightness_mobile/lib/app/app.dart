import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:brightness_mobile/core/config/app_config.dart';
import 'package:brightness_mobile/app/di.dart';
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
      ],
      child: MaterialApp(
        title: config.title,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo),
          useMaterial3: true,
        ),
        routes: {
          '/': (_) => const OnboardingScreen(),
          '/home': (_) => const HomeScreen(),
          '/home/detail': (_) => const StepsDetailPage(),
          '/home/calendar': (_) => const CalendarPage(),
          '/workout/calendar': (_) => const WorkoutPage(),
          '/settings': (_) => const SettingsPage(),
          '/map': (_) => const RunMapPage(),
          '/map/detail': (_) => const RunDetailPage(),
        },
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
