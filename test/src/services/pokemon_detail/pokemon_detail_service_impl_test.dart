import 'package:flutter_test/flutter_test.dart';
import 'package:snapfi_mobile_challenge_pokedex_roveri/src/models/pokemon_detail.dart';
import 'package:snapfi_mobile_challenge_pokedex_roveri/src/services/pokemon_detail/pokemon_detail_service.dart';
import 'package:snapfi_mobile_challenge_pokedex_roveri/src/services/pokemon_detail/pokemon_detail_service_impl.dart';

import '../mocks/mock_pokemon_detail_repository.dart';

void main() {
  late MockPokemonDetailRepository mockPokemonDetailRepository;
  late PokemonDetailService pokemonDetailService;

  setUp(() {
    mockPokemonDetailRepository = MockPokemonDetailRepository();
    pokemonDetailService =
        PokemonDetailServiceImpl(repository: mockPokemonDetailRepository);
  });

  group('fetchPokemonDetail', () {
    test('Should return a PokemonDetail', () async {
      // Arrange
      mockPokemonDetailRepository
        ..mockFetchPokemonDetailSuccess()
        ..mockFetchPokemonSpeciesSuccess();

      // Act
      final result = await pokemonDetailService.fetchPokemonDetail('bulbasaur');

      // Assert
      expect(result, isA<PokemonDetail>());
      expect(result.id, 1);
    });
  });

  group('fetchPokemonSpecies', () {
    test('Should return a String', () async {
      // Arrange
      mockPokemonDetailRepository.mockFetchPokemonSpeciesSuccess();

      // Act
      final result =
          await pokemonDetailService.fetchPokemonSpecies('bulbasaur');

      // Assert
      expect(result, isA<String>());
      expect(result, 'species');
    });
  });
}
