import 'package:flutter/material.dart';

import 'core/ui/styles/text_styles.dart';
import 'modules/pokemon/pokemon_module.dart';
import 'modules/pokemon_detail/pokemon_detail_module.dart';

part 'core/ui/themes/theme.dart';
part 'core/ui/themes/theme.g.dart';

final class AppWidget extends StatelessWidget {
  const AppWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: MaterialApp(
        routes: {
          '/': (_) => PokemonModule(),
          '/pokemon': (_) => const PokemonDetailModule(),
        },
        title: 'Pokédex Challenge',
        theme: _lightTheme,
        locale: const Locale('en', 'US'),
      ),
    );
  }
}
