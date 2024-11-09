import 'dart:convert';

import 'package:mocktail/mocktail.dart';
import 'package:snapfi_mobile_challenge_pokedex_roveri/src/core/exceptions/failure.dart';
import 'package:snapfi_mobile_challenge_pokedex_roveri/src/core/shared/data/rest_client/rest_client_response.dart';
import 'package:snapfi_mobile_challenge_pokedex_roveri/src/models/pokemon.dart';
import 'package:snapfi_mobile_challenge_pokedex_roveri/src/repositories/pokemon/pokemon_repository.dart';
import 'package:snapfi_mobile_challenge_pokedex_roveri/src/repositories/pokemon/pokemon_repository_impl.dart';
import 'package:test/test.dart';

import '../../core/fixture/fixture_reader.dart';
import '../../core/rest_client/mock_response.dart';
import '../../core/rest_client/mock_rest_client.dart';
import '../../core/rest_client/mock_rest_client_exception.dart';

void main() {
  const limit = 20;
  const offset = 0;

  late MockRestClient mockRestClient;
  late MockRestClientException mockException;
  late PokemonRepository repository;

  setUp(() {
    mockRestClient = MockRestClient();
    mockException = MockRestClientException();
    repository = PokemonRepositoryImpl(restClient: mockRestClient);
  });

  group('Group test fetchPokemon', () {
    test('Should return a List<Pokemon>', () async {
      //Arrange
      final jsonData = getJsonData(
        'src/repositories/pokemon/fixtures/fetch_pokemon_success_fixture.json',
      );

      final data = jsonDecode(jsonData) as Map<String, dynamic>;

      final mockResponse = MockResponse(data: jsonData);

      final expectedPokemon = (data['results'] as List<Object?>)
          .cast<Map<String, dynamic>>()
          .map(Pokemon.fromJson)
          .toList();

      mockRestClient.mockGetSuccess<String>(mockResponse: mockResponse);

      //Act
      final pokemon =
          await repository.fetchPokemon(limit: limit, offset: offset);

      //Assert
      expect(pokemon, isA<List<Pokemon>>());
      expect(pokemon, expectedPokemon);
    });

    test('Should throw an Error', () async {
      //Arrange
      const response = RestClientResponse(data: <String, dynamic>{});
      mockException.mockMessage('Error');
      mockRestClient.mockGetException<String>(mockException: mockException);
      when(() => mockException.response).thenReturn(response);

      //Act & Assert
      await expectLater(
        () => repository.fetchPokemon(limit: limit, offset: offset),
        throwsA(isA<Failure>()),
      );
    });
  });
}
