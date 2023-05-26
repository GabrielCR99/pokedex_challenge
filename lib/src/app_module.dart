import 'package:provider/provider.dart';

import 'app_widget.dart';
import 'modules/core/core_module.dart';

final class AppModule extends MultiProvider {
  AppModule({super.key})
      : super(providers: [CoreModule()], child: const AppWidget());
}
