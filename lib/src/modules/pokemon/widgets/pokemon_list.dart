import 'package:flutter/material.dart';

import '../../../models/pokemon.dart';
import 'pokemon_card.dart';

class PokemonList extends StatelessWidget {
  final ScrollController scrollController;
  final List<Pokemon> pokemonList;

  const PokemonList({
    required this.scrollController,
    required this.pokemonList,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      key: const PageStorageKey('pokemon_grid'),
      controller: scrollController,
      padding: const EdgeInsets.all(16),
      gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: 108,
        mainAxisSpacing: 10,
        crossAxisSpacing: 10,
        mainAxisExtent: 104,
      ),
      itemBuilder: (_, index) => PokemonCard(pokemon: pokemonList[index]),
      itemCount: pokemonList.length,
    );
  }
}
