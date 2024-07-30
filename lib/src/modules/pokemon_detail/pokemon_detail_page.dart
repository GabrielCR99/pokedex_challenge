import 'package:flutter/material.dart';

import '../../models/pokemon.dart';
import 'controller/pokemon_detail_controller.dart';
import 'widgets/loaded_pokemon_detail.dart';
import 'widgets/loading_pokemon_detail.dart';
import 'widgets/pokemon_detail_error.dart';

final class PokemonDetailPage extends StatelessWidget {
  const PokemonDetailPage({required this.pokemonDetailController, super.key});

  final PokemonDetailController pokemonDetailController;

  @override
  Widget build(BuildContext context) {
    final Pokemon(:name) =
        ModalRoute.of(context)!.settings.arguments! as Pokemon;

    return ValueListenableBuilder<PokemonDetailState>(
      valueListenable: pokemonDetailController,
      builder: (_, state, __) => switch (state.status) {
        PokemonDetailStatus.loading =>
          const LoadingPokemonDetail(key: Key('loading_pokemon_detail')),
        PokemonDetailStatus.error => PokemonDetailError(
            onRetry: () => pokemonDetailController.fetchPokemonDetail(name),
            errorMessage: state.errorMessage,
            key: const Key('pokemon_detail_error'),
          ),
        PokemonDetailStatus.loaded => LoadedPokemonDetail(
            pokemonDetailController: pokemonDetailController,
            pokemonDetail: state.pokemonDetail,
            key: const Key('loaded_pokemon_detail'),
          ),
        _ => const SizedBox.shrink()
      },
    );
  }
}
