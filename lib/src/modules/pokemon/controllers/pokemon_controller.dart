import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

import '../../../core/exceptions/failure.dart';
import '../../../models/pokemon.dart';
import '../../../services/pokemon/pokemon_service.dart';
import '../helpers/pokemon_helper.dart';

part 'pokemon_state.dart';

const _limit = 20;

interface class PokemonController extends ValueNotifier<PokemonState> {
  PokemonController({required PokemonService service})
    : _service = service,
      super(const PokemonState.initial());

  final PokemonService _service;
  var _filteredPokemon = const <Pokemon>[];

  Future<void> fetchPokemon() async {
    value = value.copyWith(status: PokemonStatus.loading);

    try {
      final result = await _service.fetchPokemon(offset: 0, limit: _limit);
      _filteredPokemon = result;

      value = value.copyWith(status: PokemonStatus.loaded, pokemonList: result);

      return;
    } on Failure catch (e) {
      value = value.copyWith(
        status: PokemonStatus.error,
        errorMessage: e.message,
      );

      return;
    }
  }

  Future<void> fetchMorePokemon() async {
    if (value.hasReachedMax) {
      return;
    }

    value = value.copyWith(status: PokemonStatus.loading, hasReachedMax: false);

    try {
      final result = await _service.fetchPokemon(
        offset: _filteredPokemon.length,
        limit: _limit,
      );
      _filteredPokemon = [..._filteredPokemon, ...result];

      value = value.copyWith(
        status: PokemonStatus.loaded,
        pokemonList: filterPokemonBySearchQuery(
          _filteredPokemon,
          value.searchQuery,
        ),
        searchQuery: value.searchQuery,
        sortBy: value.sortBy,
        hasReachedMax: _filteredPokemon.length >= 1010,
      );

      return;
    } on Failure catch (e) {
      value = value.copyWith(
        status: PokemonStatus.error,
        errorMessage: e.message,
      );

      return;
    }
  }

  void filterPokemon(String searchQuery) =>
      value = value.copyWith(
        status: PokemonStatus.loaded,
        pokemonList: filterPokemonBySearchQuery(_filteredPokemon, searchQuery),
        searchQuery: searchQuery,
        sortBy: value.sortBy,
      );

  void sortPokemon(SortBy sortBy) =>
      value = value.copyWith(
        status: PokemonStatus.loaded,
        pokemonList: filterPokemonBySearchQuery(
          _filteredPokemon = sortPokemonByType(_filteredPokemon, sortBy),
          value.searchQuery,
        ),
        searchQuery: value.searchQuery,
        sortBy: sortBy,
      );
}
