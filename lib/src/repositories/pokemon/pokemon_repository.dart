import '../../models/pokemon.dart';

abstract interface class PokemonRepository {
  Future<Iterable<Pokemon>> fetchPokemon({
    required int limit,
    required int offset,
  });
}
