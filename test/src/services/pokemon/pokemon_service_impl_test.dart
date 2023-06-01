import 'package:snapfi_mobile_challenge_pokedex_roveri/src/models/pokemon.dart';
import 'package:snapfi_mobile_challenge_pokedex_roveri/src/services/pokemon/pokemon_service.dart';
import 'package:snapfi_mobile_challenge_pokedex_roveri/src/services/pokemon/pokemon_service_impl.dart';
import 'package:test/test.dart';

import '../mocks/mock_pokemon_detail_repository.dart';
import '../mocks/mock_pokemon_repository.dart';

void main() {
  const limit = 20;
  const offset = 0;

  late MockPokemonRepository pokemonRepository;
  late MockPokemonDetailRepository pokemonDetailRepository;
  late PokemonService pokemonService;

  setUp(() {
    pokemonRepository = MockPokemonRepository();
    pokemonDetailRepository = MockPokemonDetailRepository();
    pokemonService = PokemonServiceImpl(
      pokemonRepository: pokemonRepository,
      pokemonDetailRepository: pokemonDetailRepository,
    );
  });

  group('Group test fetchPokemon', () {
    test('returns a list of Pokemon with details', () async {
      // Arrange
      pokemonRepository.mockFetchPokemonSuccess();
      pokemonDetailRepository.mockFetchPokemonDetailSuccess();

      // Act
      final result =
          await pokemonService.fetchPokemon(limit: limit, offset: offset);

      // Assert
      expect(result, isA<List<Pokemon>>());
      expect(result.first.id, '1');
    });
  });
}
