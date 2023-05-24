import '../../models/pokemon_detail.dart';

abstract interface class PokemonDetailService {
  Future<PokemonDetail> fetchPokemonDetail(String name);
  Future<String> fetchPokemonSpecies(String name);
  Future<PokemonDetail> fetchNextOrPreviousPokemonDetail({required int offset});
}
