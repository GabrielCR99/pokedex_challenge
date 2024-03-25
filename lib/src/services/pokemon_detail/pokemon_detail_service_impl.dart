import '../../models/pokemon.dart';
import '../../models/pokemon_detail.dart';
import '../../repositories/pokemon/pokemon_repository.dart';
import '../../repositories/pokemon_detail/pokemon_detail_repository.dart';
import 'pokemon_detail_service.dart';

final class PokemonDetailServiceImpl implements PokemonDetailService {
  final PokemonDetailRepository _repository;
  final PokemonRepository _pokemonRepository;

  const PokemonDetailServiceImpl({
    required PokemonDetailRepository repository,
    required PokemonRepository pokemonRepository,
  })  : _repository = repository,
        _pokemonRepository = pokemonRepository;

  @override
  Future<PokemonDetail> fetchPokemonDetail(String name) async =>
      _fetchPokemonDetailFuture(name);

  @override
  Future<String> fetchPokemonSpecies(String name) async =>
      _repository.fetchPokemonSpecies(name);

  @override
  Future<PokemonDetail> fetchNextOrPreviousPokemonDetail({
    required int offset,
  }) async {
    final List(first: Pokemon(:name)) =
        await _pokemonRepository.fetchPokemon(limit: 1, offset: offset);

    return _fetchPokemonDetailFuture(name);
  }

  Future<PokemonDetail> _fetchPokemonDetailFuture(String name) async {
    final [pokemonDetail as PokemonDetail, speciesDescription as String] =
        await Future.wait([
      _repository.fetchPokemonDetail(name),
      _repository.fetchPokemonSpecies(name),
    ]);

    return pokemonDetail.copyWith(speciesDescription: speciesDescription);
  }
}
