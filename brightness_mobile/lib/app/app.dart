import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:brightness_mobile/core/config/app_config.dart';
import 'package:brightness_mobile/core/theme/app_theme.dart';
import 'package:brightness_mobile/app/di.dart';
import 'package:brightness_mobile/app/router.dart';
import 'package:brightness_mobile/features/auth/presentation/controllers/login_controller.dart';
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
          scaffoldBackgroundColor: AppTheme.backgroundColor,
          appBarTheme: const AppBarTheme(
            backgroundColor: AppTheme.surfaceColor,
            foregroundColor: AppTheme.textPrimary,
            elevation: 0,
          ),
          inputDecorationTheme: InputDecorationTheme(
            filled: true,
            fillColor: AppTheme.backgroundColor,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(AppTheme.radiusM),
              borderSide: const BorderSide(color: AppTheme.borderColor),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(AppTheme.radiusM),
              borderSide: const BorderSide(color: AppTheme.borderColor),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(AppTheme.radiusM),
              borderSide: const BorderSide(color: AppTheme.borderFocusedColor, width: 2.0),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(AppTheme.radiusM),
              borderSide: const BorderSide(color: AppTheme.borderErrorColor),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(AppTheme.radiusM),
              borderSide: const BorderSide(color: AppTheme.borderErrorColor, width: 2.0),
            ),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: AppTheme.spacingM,
              vertical: AppTheme.spacingM,
            ),
          ),
        ),
        home: const FeedScreen(),
        onGenerateRoute: AppRouter.generateRoute,
      ),
    );
  }
}
