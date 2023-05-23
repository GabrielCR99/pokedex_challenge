import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

import 'controller/pokemon_detail_controller.dart';

final class PokemonDetailModule extends MultiProvider {
  PokemonDetailModule({required Widget child, super.key})
      : super(
          providers: [
            BlocProvider(
              create: (context) =>
                  PokemonDetailController(service: context.read()),
            ),
          ],
          child: child,
        );
}
