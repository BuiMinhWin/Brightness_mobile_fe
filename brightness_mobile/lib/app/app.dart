import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../app/router.dart';
import '../core/config/app_config.dart';
import '../core/theme/app_colors.dart';
import '../core/theme/app_theme.dart';
import '../features/auth/presentation/controllers/login_controller.dart';
import '../features/auth/presentation/controllers/register_controller.dart';
import '../features/auth/presentation/pages/register_page.dart';
import '../features/home/presentation/controllers/home_controller.dart';
import '../features/onboarding/presentation/controllers/onboarding_controller.dart';
import '../features/pricing/presentation/pages/pricing_page.dart';
import '../features/auth/presentation/pages/login_page.dart';
import '../core/navigation/main_navigation_controller.dart';
import 'di.dart' as di;

class App extends StatelessWidget {
  const App({super.key, this.config});

  final AppConfig? config;

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<OnboardingController>(
          create: (_) => di.sl<OnboardingController>(),
        ),
        ChangeNotifierProvider<HomeController>(
          create: (_) => di.sl<HomeController>(),
        ),
        ChangeNotifierProvider<LoginController>(
          create: (_) => di.sl<LoginController>(),
        ),
        ChangeNotifierProvider<RegisterController>(
          create: (_) => di.sl<RegisterController>(),
        ),
      ],
      child: MaterialApp(
        title: 'BrightNest',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primaryColor: AppColors.primary,
          colorScheme: ColorScheme.fromSeed(
            seedColor: AppColors.primary,
            primary: AppColors.primary,
            secondary: AppColors.secondary,
            surface: AppColors.white,
          ),
          scaffoldBackgroundColor: AppColors.backgroundLight,
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
          useMaterial3: true,
        ),
        initialRoute: AppRouter.home,
        onGenerateRoute: AppRouter.generateRoute,
        routes: {
          '/login': (context) => const LoginPage(),
          '/register': (context) => const RegisterPage(),
          '/main': (context) => const MainNavigationController(),
          '/pricing': (context) => const PricingPage(),
        },
      ),
    );
  }
}
