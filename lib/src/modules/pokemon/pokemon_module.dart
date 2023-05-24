import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

import 'controllers/pokemon_controller.dart';
import 'pokemon_page.dart';

final class PokemonModule extends MultiProvider {
  PokemonModule({super.key})
      : super(
          providers: [
            BlocProvider(
              create: (context) =>
                  PokemonController(service: context.read())..fetchPokemon(),
              lazy: false,
            ),
          ],
          child: const PokemonPage(),
        );
}
