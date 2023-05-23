import 'package:flutter/material.dart';

import 'core/ui/styles/text_styles.dart';
import 'models/pokemon.dart';
import 'modules/pokemon/pokemon_module.dart';
import 'modules/pokemon/pokemon_page.dart';
import 'modules/pokemon_detail/pokemon_detail_module.dart';
import 'modules/pokemon_detail/pokemon_detail_page.dart';

part 'core/ui/themes/theme.dart';
part 'core/ui/themes/theme.g.dart';

class AppWidget extends StatelessWidget {
  const AppWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: MaterialApp(
        routes: {
          '/': (_) => PokemonModule(child: const PokemonPage()),
          '/pokemon': (context) => PokemonDetailModule(
                child: PokemonDetailPage(
                  pokemon:
                      ModalRoute.of(context)!.settings.arguments! as Pokemon,
                ),
              ),
        },
        title: 'Snapfi Pokedex Challenge',
        theme: _lightTheme,
        darkTheme: _darkTheme,
        locale: const Locale('en'),
        supportedLocales: const [Locale('en')],
      ),
    );
  }
}
