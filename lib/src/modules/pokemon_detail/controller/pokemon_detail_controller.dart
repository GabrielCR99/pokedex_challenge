import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import '../../../core/exceptions/failure.dart';
import '../../../models/pokemon_detail.dart';
import '../../../services/pokemon_detail/pokemon_detail_service.dart';

part 'pokemon_detail_state.dart';

const _bulbasaurId = 1;

interface class PokemonDetailController
    extends ValueNotifier<PokemonDetailState> {
  PokemonDetailController({required PokemonDetailService service})
      : _service = service,
        super(const PokemonDetailState.initial());

  final PokemonDetailService _service;

  Future<void> fetchPokemonDetail(String name) async {
    value = value.copyWith(status: PokemonDetailStatus.loading);

    try {
      final pokemonDetail = await _service.fetchPokemonDetail(name);

      value = value.copyWith(
        status: PokemonDetailStatus.loaded,
        pokemonDetail: pokemonDetail,
      );

      return;
    } on Failure catch (e) {
      value = value.copyWith(
        status: PokemonDetailStatus.error,
        errorMessage: e.message,
      );

      return;
    }
  }

  Future<void> fetchNextPokemon() async {
    // ! That's because bulbasaur's id is 1
    final nextPokemonId = value.pokemonDetail.id - _bulbasaurId + 1;
    value = value.copyWith(status: PokemonDetailStatus.loading);

    try {
      final pokemonDetail = await _service.fetchNextOrPreviousPokemonDetail(
        offset: nextPokemonId,
      );

      value = value.copyWith(
        status: PokemonDetailStatus.loaded,
        pokemonDetail: pokemonDetail,
      );

      return;
    } on Failure catch (e) {
      value = value.copyWith(
        status: PokemonDetailStatus.error,
        errorMessage: e.message,
      );

      return;
    }
  }

  Future<void> fetchPreviousPokemon() async {
    if (value.pokemonDetail.id == _bulbasaurId) {
      return;
    }

    final nextPokemonId = value.pokemonDetail.id - _bulbasaurId - 1;

    value = value.copyWith(status: PokemonDetailStatus.loading);

    try {
      final pokemonDetail = await _service.fetchNextOrPreviousPokemonDetail(
        offset: nextPokemonId,
      );

      value = value.copyWith(
        status: PokemonDetailStatus.loaded,
        pokemonDetail: pokemonDetail,
      );

      return;
    } on Failure catch (e) {
      value = value.copyWith(
        status: PokemonDetailStatus.error,
        errorMessage: e.message,
      );

      return;
    }
  }
}
