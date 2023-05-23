import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:snapfi_mobile_challenge_pokedex_roveri/src/core/shared/domain/failures/failure.dart';
import 'package:snapfi_mobile_challenge_pokedex_roveri/src/models/pokemon.dart';
import 'package:snapfi_mobile_challenge_pokedex_roveri/src/repositories/pokemon/pokemon_repository.dart';
import 'package:snapfi_mobile_challenge_pokedex_roveri/src/repositories/pokemon/pokemon_repository_impl.dart';

import '../../core/fixture/fixture_reader.dart';
import '../../core/rest_client/mock_response.dart';
import '../../core/rest_client/mock_rest_client.dart';
import '../../core/rest_client/mock_rest_client_exception.dart';

void main() {
  const limit = 20;
  const offset = 0;

  late MockRestClient<Map<String, dynamic>> mockRestClient;
  late MockRestClientException<Map<String, dynamic>> mockException;
  late PokemonRepository repository;

  setUp(() {
    mockRestClient = MockRestClient();
    mockException = MockRestClientException();
    repository = PokemonRepositoryImpl(restClient: mockRestClient);
  });

  group('Group test fetchPokemon', () {
    test('Should return a List<Pokemon>', () async {
      //Arrange
      final jsonData = FixtureReader.getJsonData(
        'src/repositories/pokemon/fixtures/fetch_pokemon_success_fixture.json',
      );

      final data = jsonDecode(jsonData) as Map<String, dynamic>;

      final mockResponse = MockResponse(data: data);

      final expectedPokemon = (data['results'] as List)
          .cast<Map<String, dynamic>>()
          .map(Pokemon.fromJson)
          .toList();

      mockRestClient.mockGetSuccess(mockResponse: mockResponse);

      //Act
      final pokemon =
          await repository.fetchPokemon(limit: limit, offset: offset);

      //Assert
      expect(pokemon, isA<List<Pokemon>>());
      expect(pokemon, expectedPokemon);
    });

    test('Should throw an Error', () {
      //Arrange
      mockException.mockMessage('Error');

      mockRestClient.mockGetException(
        mockException: mockException,
        queryParameters: {'limit': limit, 'offset': offset},
      );

      //Act
      final call = repository.fetchPokemon;

      //Assert
      expect(() => call(limit: limit, offset: offset), throwsA(isA<Failure>()));
    });
  });
}
