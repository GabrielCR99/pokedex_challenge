import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../models/pokemon.dart';
import 'controller/pokemon_detail_controller.dart';
import 'widgets/loaded_pokemon_detail.dart';
import 'widgets/loading_pokemon_detail.dart';
import 'widgets/pokemon_detail_error.dart';

final class PokemonDetailPage extends StatelessWidget {
  const PokemonDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    final Pokemon(:name) =
        ModalRoute.of(context)!.settings.arguments! as Pokemon;

    return BlocBuilder<PokemonDetailController, PokemonDetailState>(
      builder: (_, state) => switch (state.status) {
        PokemonDetailStatus.loading =>
          const LoadingPokemonDetail(key: Key('loading_pokemon_detail')),
        PokemonDetailStatus.error => PokemonDetailError(
            onRetry: () => context
                .read<PokemonDetailController>()
                .fetchPokemonDetail(name),
            errorMessage: state.errorMessage,
            key: const Key('pokemon_detail_error'),
          ),
        PokemonDetailStatus.loaded => LoadedPokemonDetail(
            pokemonDetail: state.pokemonDetail,
            key: const Key('loaded_pokemon_detail'),
          ),
        _ => const SizedBox.shrink()
      },
    );
  }
}
