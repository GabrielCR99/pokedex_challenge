part of 'pokemon_controller.dart';

enum PokemonStatus {
  initial,
  loading,
  loaded,
  error;
}

final class PokemonState extends Equatable {
  final PokemonStatus status;
  final List<Pokemon> pokemonList;
  final bool hasReachedMax;
  final String searchQuery;
  final SortBy sortBy;
  final String? errorMessage;

  const PokemonState._({
    required this.status,
    required this.pokemonList,
    this.hasReachedMax = false,
    this.searchQuery = '',
    this.sortBy = SortBy.number,
    this.errorMessage,
  });

  const PokemonState.initial()
      : status = PokemonStatus.initial,
        pokemonList = const [],
        hasReachedMax = false,
        searchQuery = '',
        sortBy = SortBy.number,
        errorMessage = null;

  PokemonState copyWith({
    required PokemonStatus status,
    List<Pokemon>? pokemonList,
    bool? hasReachedMax,
    String? searchQuery,
    SortBy? sortBy,
    String? errorMessage,
  }) =>
      PokemonState._(
        status: status,
        pokemonList: pokemonList ?? this.pokemonList,
        hasReachedMax: hasReachedMax ?? this.hasReachedMax,
        searchQuery: searchQuery ?? this.searchQuery,
        sortBy: sortBy ?? this.sortBy,
        errorMessage: errorMessage ?? this.errorMessage,
      );

  @override
  List<Object?> get props =>
      [pokemonList, hasReachedMax, searchQuery, sortBy, errorMessage, status];
}
