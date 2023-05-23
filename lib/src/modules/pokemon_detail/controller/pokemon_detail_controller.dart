import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/shared/domain/failures/failure.dart';
import '../../../models/pokemon_detail.dart';
import '../../../services/pokemon_detail/pokemon_detail_service.dart';

part 'pokemon_detail_state.dart';

final class PokemonDetailController extends Cubit<PokemonDetailState> {
  final PokemonDetailService _service;

  PokemonDetailController({required PokemonDetailService service})
      : _service = service,
        super(const PokemonDetailState.initial());

  Future<void> fetchPokemonDetail(String name) async {
    emit(state.copyWith(status: PokemonDetailStatus.loading));

    try {
      final pokemonDetail = await _service.fetchPokemonDetail(name);

      emit(
        state.copyWith(
          status: PokemonDetailStatus.loaded,
          pokemonDetail: pokemonDetail,
        ),
      );
    } on Failure catch (e) {
      emit(
        state.copyWith(
          status: PokemonDetailStatus.error,
          errorMessage: e.message,
        ),
      );
    }
  }
}
