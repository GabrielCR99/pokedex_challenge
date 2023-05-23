import '../../models/pokemon.dart';
import '../../repositories/pokemon/pokemon_repository.dart';
import '../../repositories/pokemon_detail/pokemon_detail_repository.dart';
import 'pokemon_service.dart';

final class PokemonServiceImpl implements PokemonService {
  final PokemonRepository _pokemonRepository;
  final PokemonDetailRepository _pokemonDetailRepository;

  const PokemonServiceImpl({
    required PokemonRepository pokemonRepository,
    required PokemonDetailRepository pokemonDetailRepository,
  })  : _pokemonRepository = pokemonRepository,
        _pokemonDetailRepository = pokemonDetailRepository;

  @override
  Future<List<Pokemon>> fetchPokemon({
    required int limit,
    required int offset,
  }) async {
    final pokemonList =
        await _pokemonRepository.fetchPokemon(limit: limit, offset: offset);

    return Future.wait(
      pokemonList.map(
        (pokemon) async {
          final pokemonDetail =
              await _pokemonDetailRepository.fetchPokemonDetail(pokemon.name);

          return pokemon.copyWith(
            imageUrl: pokemonDetail.imageUrl,
            id: pokemonDetail.id.toString(),
          );
        },
      ),
    );
  }
}
