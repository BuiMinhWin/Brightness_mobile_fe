import 'package:flutter/material.dart';

import 'package:brightness_mobile/app/app.dart';
import 'package:brightness_mobile/app/di.dart' as di;
import 'package:brightness_mobile/core/config/app_config.dart';
import 'package:flutter_web_plugins/url_strategy.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize DI/services
  await di.init();

  // Load config from compile-time environment (defaults to dev)
  final config = AppConfig.fromEnvironment();

  // Better web URLs: /home instead of #/home
  usePathUrlStrategy();
  runApp(App(config: config));
}
