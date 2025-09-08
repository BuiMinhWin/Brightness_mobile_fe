// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';

// import 'package:brightness_mobile/core/config/app_config.dart';
// import 'package:brightness_mobile/app/di.dart';
// import 'package:brightness_mobile/features/auth/presentation/pages/login_page.dart';
// import 'package:brightness_mobile/features/auth/presentation/controllers/login_controller.dart';

// class App extends StatelessWidget {
//   final AppConfig config;
//   const App({super.key, required this.config});

//   @override
//   Widget build(BuildContext context) {
//     return MultiProvider(
//       providers: [
//         ChangeNotifierProvider<LoginController>(
//           create: (_) => sl<LoginController>(),
//         ),
//       ],
//       child: MaterialApp(
//         title: config.title,
//         theme: ThemeData(
//           colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo),
//           useMaterial3: true,
//         ),
//         home: const LoginPage(),
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../features/auth/presentation/pages/login_page.dart';
import '../features/auth/presentation/controllers/login_controller.dart';
import 'di.dart' as di;

class BrightNestApp extends StatelessWidget {
  const BrightNestApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'BrightNest',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.green,
        fontFamily: 'Inter', // You can change this to your preferred font
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: ChangeNotifierProvider(
        create: (_) => di.sl<LoginController>(),
        child: const LoginPage(),
      ),
      // You can add routing here later
      routes: {
        '/login': (context) => ChangeNotifierProvider(
              create: (_) => di.sl<LoginController>(),
              child: const LoginPage(),
            ),
        // Add more routes as needed
      },
    );
  }
}