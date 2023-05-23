import '../../models/pokemon.dart';

abstract interface class PokemonService {
  Future<List<Pokemon>> fetchPokemon({required int limit, required int offset});
}
