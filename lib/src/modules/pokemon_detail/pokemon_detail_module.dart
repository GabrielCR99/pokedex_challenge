import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

import '../../models/pokemon.dart';
import 'controller/pokemon_detail_controller.dart';
import 'pokemon_detail_page.dart';

final class PokemonDetailModule extends MultiProvider {
  PokemonDetailModule({super.key})
      : super(
          providers: [
            BlocProvider(
              create: (context) =>
                  PokemonDetailController(service: context.read()),
            ),
          ],
          builder: (context, _) => PokemonDetailPage(
            pokemon: ModalRoute.of(context)!.settings.arguments! as Pokemon,
          ),
        );
}
