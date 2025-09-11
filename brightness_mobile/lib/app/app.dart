import 'package:brightness_mobile/features/auth/presentation/controllers/register_controller.dart';
import 'package:brightness_mobile/features/auth/presentation/pages/register_page.dart';
import 'package:brightness_mobile/features/pricing/presentation/pages/pricing_page.dart';
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
import '../features/auth/presentation/pages/login_page.dart';
import '../features/auth/presentation/controllers/login_controller.dart';
import '../core/theme/app_colors.dart';
import '../core/theme/app_theme.dart';
import 'di.dart' as di;
import '../core/navigation/main_navigation_controller.dart';

class BrightNestApp extends StatelessWidget {
  const BrightNestApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'BrightNest',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: AppColors.primary,
        colorScheme: ColorScheme.fromSeed(
          seedColor: AppColors.primary,
          primary: AppColors.primary,
          secondary: AppColors.secondary,
          background: AppColors.backgroundLight,
          surface: AppColors.white,
        ),
        fontFamily: 'Inter',
        visualDensity: VisualDensity.adaptivePlatformDensity,
        textTheme: TextTheme(
          headlineLarge: AppTheme.textStyleHeadline1,
          headlineMedium: AppTheme.textStyleHeadline2,
          headlineSmall: AppTheme.textStyleHeadline3,
          bodyLarge: AppTheme.textStyleBody1,
          bodyMedium: AppTheme.textStyleBody2,
          labelLarge: AppTheme.textStyleButton,
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: AppTheme.primaryButtonStyle(),
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
        outlinedButtonTheme: OutlinedButtonThemeData(
          style: AppTheme.secondaryButtonStyle(),
        ),
        inputDecorationTheme: InputDecorationTheme(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(AppTheme.radiusM),
            borderSide: const BorderSide(color: AppColors.border),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(AppTheme.radiusM),
            borderSide: const BorderSide(color: AppColors.border),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(AppTheme.radiusM),
            borderSide: const BorderSide(color: AppColors.primary),
          ),
        ),
      ),
      // home: const MainNavigationController(), // Use the main navigation controller
       home: ChangeNotifierProvider(
        create: (_) => di.sl<LoginController>(),
        child: const LoginPage(),
      ),
      routes: {
        '/login': (context) => ChangeNotifierProvider(
              create: (_) => di.sl<LoginController>(),
              child: const LoginPage(),
            ),
        '/register': (context) => ChangeNotifierProvider(
              create: (_) => di.sl<RegisterController>(),
              child: const RegisterPage(),
            ),
        '/main': (context) => const MainNavigationController(),
        '/pricing': (context) => const PricingPage(),
        // Add more routes as needed
      },
    );
  }
}