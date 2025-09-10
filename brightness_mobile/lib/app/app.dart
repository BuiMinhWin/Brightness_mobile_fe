
import 'package:brightness_mobile/features/auth/presentation/controllers/register_controller.dart';
import 'package:brightness_mobile/features/auth/presentation/pages/register_page.dart';
import 'package:brightness_mobile/features/pricing/presentation/pages/pricing_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../features/auth/presentation/pages/login_page.dart';
import '../features/auth/presentation/controllers/login_controller.dart';
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
        primarySwatch: Colors.green,
        fontFamily: 'Inter',
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: const MainNavigationController(), // Use the main navigation controller
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