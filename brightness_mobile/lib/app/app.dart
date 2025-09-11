import 'package:brightness_mobile/features/auth/presentation/controllers/register_controller.dart';
import 'package:brightness_mobile/features/auth/presentation/pages/register_page.dart';
import 'package:brightness_mobile/features/pricing/presentation/pages/pricing_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
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