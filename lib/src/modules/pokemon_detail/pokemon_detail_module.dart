import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/pokemon.dart';
import 'controller/pokemon_detail_controller.dart';
import 'pokemon_detail_page.dart';

final class PokemonDetailModule extends StatelessWidget {
  const PokemonDetailModule({super.key});

  @override
  Widget build(BuildContext context) {
    final Pokemon(:name) =
        ModalRoute.of(context)!.settings.arguments! as Pokemon;

    return ChangeNotifierProvider(
      create: (_) => PokemonDetailController(service: context.read())
        ..fetchPokemonDetail(name),
      builder: (context, _) =>
          PokemonDetailPage(pokemonDetailController: context.read()),
    );
  }
}
