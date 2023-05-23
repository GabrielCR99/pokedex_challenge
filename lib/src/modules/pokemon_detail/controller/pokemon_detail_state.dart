part of 'pokemon_detail_controller.dart';

enum PokemonDetailStatus {
  initial,
  loading,
  speciesLoading,
  loaded,
  speciesLoaded,
  error,
}

final class PokemonDetailState extends Equatable {
  final PokemonDetailStatus status;
  final String? errorMessage;
  final PokemonDetail pokemonDetail;
  final String? speciesDetail;

  const PokemonDetailState._({
    required this.status,
    required this.pokemonDetail,
    this.errorMessage,
    this.speciesDetail = '',
  });

  const PokemonDetailState.initial()
      : this._(
          status: PokemonDetailStatus.initial,
          pokemonDetail: const PokemonDetail(
            id: 0,
            height: 0,
            weight: 0,
            imageUrl: '',
            moves: [],
            stats: [],
          ),
        );

  PokemonDetailState copyWith({
    PokemonDetailStatus? status,
    String? errorMessage,
    PokemonDetail? pokemonDetail,
    String? speciesDetail,
  }) =>
      PokemonDetailState._(
        status: status ?? this.status,
        pokemonDetail: pokemonDetail ?? this.pokemonDetail,
        errorMessage: errorMessage ?? this.errorMessage,
        speciesDetail: speciesDetail ?? this.speciesDetail,
      );

  @override
  List<Object?> get props =>
      [status, errorMessage, pokemonDetail, speciesDetail];
}
