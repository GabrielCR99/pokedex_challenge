import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

Future<void> configureApp() async {
  WidgetsFlutterBinding.ensureInitialized();

  await SystemChrome.setPreferredOrientations(
    [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown],
  );
}
