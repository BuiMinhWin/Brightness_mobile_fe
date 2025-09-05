import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:brightness_mobile/core/config/app_config.dart';
import 'package:brightness_mobile/app/di.dart';
import 'package:brightness_mobile/features/auth/presentation/pages/login_page.dart';
import 'package:brightness_mobile/features/auth/presentation/controllers/login_controller.dart';

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
      ],
      child: MaterialApp(
        title: config.title,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo),
          useMaterial3: true,
        ),
        home: const LoginPage(),
      ),
    );
  }
}
