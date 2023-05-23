import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'modules/core/core_module.dart';

class AppModule extends MultiProvider {
  AppModule({required Widget child, super.key})
      : super(providers: [CoreModule()], child: child);
}
