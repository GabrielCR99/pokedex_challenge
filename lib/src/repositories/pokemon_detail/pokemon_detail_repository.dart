import '../../models/pokemon_detail.dart';

abstract interface class PokemonDetailRepository {
  Future<PokemonDetail> fetchPokemonDetail(String name);
  Future<String> fetchPokemonSpecies(String name);
}
