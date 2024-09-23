part of 'pokemon_detail_controller.dart';

enum PokemonDetailStatus {
  initial,
  loading,
  loaded,
  error;
}

interface class PokemonDetailState extends Equatable {
  final PokemonDetailStatus status;
  final PokemonDetail pokemonDetail;
  final String? speciesDetail;
  final String? errorMessage;

  const PokemonDetailState._({
    required this.status,
    required this.pokemonDetail,
    this.errorMessage,
    this.speciesDetail = '',
  });

  const PokemonDetailState.initial()
      : status = PokemonDetailStatus.initial,
        pokemonDetail = const PokemonDetail.empty(),
        speciesDetail = null,
        errorMessage = null;

  PokemonDetailState copyWith({
    required PokemonDetailStatus status,
    String? errorMessage,
    PokemonDetail? pokemonDetail,
    String? speciesDetail,
  }) =>
      PokemonDetailState._(
        status: status,
        pokemonDetail: pokemonDetail ?? this.pokemonDetail,
        errorMessage: errorMessage ?? this.errorMessage,
        speciesDetail: speciesDetail ?? this.speciesDetail,
      );

  @override
  List<Object?> get props =>
      [status, errorMessage, pokemonDetail, speciesDetail];
}
