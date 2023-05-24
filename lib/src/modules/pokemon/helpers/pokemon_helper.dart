import '../../../models/pokemon.dart';

enum SortBy {
  number('Number'),
  name('Name');

  final String value;

  const SortBy(this.value);
}

List<Pokemon> sortPokemonByType(List<Pokemon> pokemonList, SortBy sortBy) =>
    switch (sortBy) {
      SortBy.number => pokemonList
        ..sort((a, b) => a.sanitizedId.compareTo(b.sanitizedId)),
      SortBy.name => pokemonList..sort((a, b) => a.name.compareTo(b.name))
    };

List<Pokemon> filterPokemonBySearchQuery(
  List<Pokemon> pokemonList,
  String searchQuery,
) =>
    pokemonList
        .where(
          (pokemon) =>
              pokemon.name.contains(searchQuery.toLowerCase()) ||
              pokemon.sanitizedId.contains(searchQuery),
        )
        .toList();
