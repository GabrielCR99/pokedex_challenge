import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/shared/domain/failures/failure.dart';
import '../../../models/pokemon.dart';
import '../../../services/pokemon/pokemon_service.dart';
import '../helpers/pokemon_helper.dart';

part 'pokemon_state.dart';

final class PokemonController extends Cubit<PokemonState> {
  var _filteredPokemon = const <Pokemon>[];
  static const _limit = 20;

  final PokemonService _service;

  PokemonController({required PokemonService service})
      : _service = service,
        super(const PokemonState.initial());

  Future<void> fetchPokemon() async {
    emit(state.copyWith(status: PokemonStatus.loading));

    try {
      final result = await _service.fetchPokemon(offset: 0, limit: _limit);
      _filteredPokemon = result;

      emit(state.copyWith(status: PokemonStatus.loaded, pokemonList: result));
    } on Failure catch (e) {
      emit(
        state.copyWith(status: PokemonStatus.error, errorMessage: e.message),
      );
    }
  }

  Future<void> fetchMorePokemon() async {
    if (state.hasReachedMax) {
      return;
    }

    emit(state.copyWith(status: PokemonStatus.loading, hasReachedMax: false));

    try {
      final result = await _service.fetchPokemon(
        offset: _filteredPokemon.length,
        limit: _limit,
      );
      _filteredPokemon = [..._filteredPokemon, ...result];

      emit(
        state.copyWith(
          status: PokemonStatus.loaded,
          pokemonList:
              filterPokemonBySearchQuery(_filteredPokemon, state.searchQuery),
          searchQuery: state.searchQuery,
          sortBy: state.sortBy,
          hasReachedMax: _filteredPokemon.length >= 1118,
        ),
      );
    } on Failure catch (e) {
      emit(
        state.copyWith(status: PokemonStatus.error, errorMessage: e.message),
      );
    }
  }

  void filterPokemon(String searchQuery) => emit(
        state.copyWith(
          status: PokemonStatus.loaded,
          pokemonList:
              filterPokemonBySearchQuery(_filteredPokemon, searchQuery),
          searchQuery: searchQuery,
          sortBy: state.sortBy,
        ),
      );

  void sortPokemon(SortBy sortBy) {
    _filteredPokemon = sortPokemonByType(_filteredPokemon, sortBy);

    emit(
      state.copyWith(
        status: PokemonStatus.loaded,
        pokemonList:
            filterPokemonBySearchQuery(_filteredPokemon, state.searchQuery),
        searchQuery: state.searchQuery,
        sortBy: sortBy,
      ),
    );
  }
}
