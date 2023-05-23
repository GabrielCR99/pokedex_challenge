import '../../models/pokemon_detail.dart';
import '../../repositories/pokemon_detail/pokemon_detail_repository.dart';
import 'pokemon_detail_service.dart';

final class PokemonDetailServiceImpl implements PokemonDetailService {
  final PokemonDetailRepository _repository;

  const PokemonDetailServiceImpl({required PokemonDetailRepository repository})
      : _repository = repository;

  @override
  Future<PokemonDetail> fetchPokemonDetail(String name) async {
    final pokemonFuture = await Future.wait([
      _repository.fetchPokemonDetail(name),
      _repository.fetchPokemonSpecies(name),
    ]);

    return (pokemonFuture.first as PokemonDetail)
        .copyWith(speciesDescription: pokemonFuture.last as String);
  }

  @override
  Future<String> fetchPokemonSpecies(String name) async =>
      _repository.fetchPokemonSpecies(name);
}
