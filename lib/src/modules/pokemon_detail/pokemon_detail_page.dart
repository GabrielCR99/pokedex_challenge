import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../models/pokemon.dart';
import 'controller/pokemon_detail_controller.dart';
import 'widgets/loaded_pokemon_detail.dart';
import 'widgets/loading_pokemon_detail.dart';
import 'widgets/pokemon_detail_error.dart';

class PokemonDetailPage extends StatefulWidget {
  final Pokemon pokemon;

  const PokemonDetailPage({required this.pokemon, super.key});

  @override
  State<PokemonDetailPage> createState() => _PokemonDetailPageState();
}

class _PokemonDetailPageState extends State<PokemonDetailPage> {
  PokemonDetailController get _controller =>
      context.read<PokemonDetailController>();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(
      (_) => _controller.fetchPokemonDetail(widget.pokemon.name),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PokemonDetailController, PokemonDetailState>(
      builder: (_, state) => switch (state.status) {
        PokemonDetailStatus.loading => const LoadingPokemonDetail(),
        PokemonDetailStatus.error =>
          PokemonDetailError(errorMessage: state.errorMessage),
        PokemonDetailStatus.loaded => LoadedPokemonDetail(
            pokemon: widget.pokemon,
            pokemonDetail: state.pokemonDetail,
          ),
        _ => const SizedBox.shrink()
      },
    );
  }
}
