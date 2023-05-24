import 'package:flutter/material.dart';

import 'src/app_module.dart';
import 'src/app_widget.dart';
import 'src/core/app_config.dart';

Future<void> main() async {
  await configureApp();

  return runApp(AppModule(child: const AppWidget()));
}
