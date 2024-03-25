import '../../models/pokemon.dart';

abstract interface class PokemonRepository {
  Future<List<Pokemon>> fetchPokemon({
    required int limit,
    required int offset,
  });
}
