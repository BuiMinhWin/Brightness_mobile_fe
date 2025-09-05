import 'package:flutter/material.dart';

import 'package:brightness_mobile/app/app.dart';
import 'package:brightness_mobile/app/di.dart';
import 'package:brightness_mobile/core/config/app_config.dart';
import 'package:brightness_mobile/core/config/app_flavor.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final flavor = F.fromEnv();
  F.setFlavor(flavor);
  final config = AppConfig.forFlavor(flavor);

  await initServices(config);

  runApp(App(config: config));
}
