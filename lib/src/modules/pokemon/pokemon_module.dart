import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

import 'controllers/pokemon_controller.dart';

final class PokemonModule extends MultiProvider {
  PokemonModule({required Widget child, super.key})
      : super(
          providers: [
            BlocProvider(
              create: (context) =>
                  PokemonController(service: context.read())..fetchPokemon(),
              lazy: false,
            ),
          ],
          child: child,
        );
}
