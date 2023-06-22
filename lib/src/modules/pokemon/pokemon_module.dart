import 'package:flutter_bloc/flutter_bloc.dart';

import 'controllers/pokemon_controller.dart';
import 'pokemon_page.dart';

final class PokemonModule extends BlocProvider<PokemonController> {
  PokemonModule({super.key})
      : super(
          create: (context) =>
              PokemonController(service: context.read())..fetchPokemon(),
          child: const PokemonPage(),
        );
}
