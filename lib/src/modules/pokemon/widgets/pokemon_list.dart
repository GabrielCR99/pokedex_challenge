import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../models/pokemon.dart';
import '../controllers/pokemon_controller.dart';
import 'pokemon_card.dart';

class PokemonList extends StatefulWidget {
  final List<Pokemon> pokemonList;

  const PokemonList({required this.pokemonList, super.key});

  @override
  State<PokemonList> createState() => _PokemonListState();
}

class _PokemonListState extends State<PokemonList> {
  final _scrollController = ScrollController();

  bool get hasReachedEndScroll {
    if (!_scrollController.hasClients) {
      return false;
    }

    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.offset;
    final isScrollOutOfRange = _scrollController.position.outOfRange;

    return currentScroll >= maxScroll && !isScrollOutOfRange;
  }

  void _scrollListener() {
    if (hasReachedEndScroll) {
      context.read<PokemonController>().fetchMorePokemon();
    }
  }

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_scrollListener);
  }

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      key: const PageStorageKey('pokemon_grid'),
      controller: _scrollController,
      padding: const EdgeInsets.all(16),
      gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: 108,
        mainAxisSpacing: 10,
        crossAxisSpacing: 10,
        mainAxisExtent: 104,
      ),
      itemBuilder: (_, index) =>
          PokemonCard(pokemon: widget.pokemonList[index]),
      itemCount: widget.pokemonList.length,
    );
  }

  @override
  void dispose() {
    _scrollController
      ..removeListener(_scrollListener)
      ..dispose();
    super.dispose();
  }
}
