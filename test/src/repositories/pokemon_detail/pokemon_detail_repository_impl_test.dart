import 'dart:convert';

import 'package:mocktail/mocktail.dart';
import 'package:snapfi_mobile_challenge_pokedex_roveri/src/core/exceptions/failure.dart';
import 'package:snapfi_mobile_challenge_pokedex_roveri/src/core/shared/data/rest_client/rest_client_response.dart';
import 'package:snapfi_mobile_challenge_pokedex_roveri/src/models/pokemon_detail.dart';
import 'package:snapfi_mobile_challenge_pokedex_roveri/src/repositories/pokemon_detail/pokemon_detail_repository.dart';
import 'package:snapfi_mobile_challenge_pokedex_roveri/src/repositories/pokemon_detail/pokemon_detail_repository_impl.dart';
import 'package:test/test.dart';

import '../../core/fixture/fixture_reader.dart';
import '../../core/rest_client/mock_response.dart';
import '../../core/rest_client/mock_rest_client.dart';
import '../../core/rest_client/mock_rest_client_exception.dart';

void main() {
  late MockRestClient mockRestClient;
  late MockRestClientException mockException;
  late PokemonDetailRepository repository;

  setUp(() {
    mockRestClient = MockRestClient();
    mockException = MockRestClientException();
    repository = PokemonDetailRepositoryImpl(restClient: mockRestClient);
  });

  group('Group test fetchPokemonDetail', () {
    test('Should return a PokemonDetail', () async {
      //Arrange
      final jsonData = getJsonData(
        'src/repositories/pokemon_detail/fixtures/fetch_pokemon_detail_success_fixture.json',
      );

      final data = jsonDecode(jsonData) as Map<String, dynamic>;

      final mockResponse = MockResponse(data: data);

      final expectedPokemonDetail = PokemonDetail.fromJson(data);

      mockRestClient.mockGetSuccess(mockResponse: mockResponse);

      //Act
      final pokemonDetail = await repository.fetchPokemonDetail('ditto');

      //Assert
      expect(pokemonDetail, isA<PokemonDetail>());
      expect(pokemonDetail, expectedPokemonDetail);
    });

    test('Should throw an Error', () async {
      //Arrange
      const response = RestClientResponse(data: <String, dynamic>{});
      mockException.mockMessage('Error');
      mockRestClient.mockGetException<Map<String, dynamic>>(
        mockException: mockException,
      );
      when(() => mockException.response).thenReturn(response);

      //Act & Assert
      await expectLater(
        () => repository.fetchPokemonDetail('ditto'),
        throwsA(isA<Failure>()),
      );
    });
  });

  group('Group test fetchPokemonSpecies', () {
    test(
      'Should return a String with the pokemon species description',
      () async {
        //Arrange
        final jsonData = getJsonData(
          'src/repositories/pokemon_detail/fixtures/fetch_pokemon_species_success_fixture.json',
        );

        final data = jsonDecode(jsonData) as Map<String, dynamic>;

        final mockResponse = MockResponse(data: data);

        final expectedPokemonSpecies = (data['flavor_text_entries'] as List)
            .cast<Map<String, dynamic>>()
            .where((e) => e['language']['name'] == 'en')
            .toList()
            .first['flavor_text'] as String;

        mockRestClient.mockGetSuccess(mockResponse: mockResponse);

        //Act
        final pokemonSpecies =
            await repository.fetchPokemonSpecies('bulbasaur');

        //Assert
        expect(pokemonSpecies, isA<String>());
        expect(pokemonSpecies, expectedPokemonSpecies);
      },
    );

    test('Should throw an Error', () async {
      //Arrange
      const response = RestClientResponse(data: <String, dynamic>{});
      mockException.mockMessage('Error');
      mockRestClient.mockGetException<Map<String, dynamic>>(
        mockException: mockException,
      );
      when(() => mockException.response).thenReturn(response);

      //Act & Assert
      await expectLater(
        () => repository.fetchPokemonSpecies('bulbasaur'),
        throwsA(isA<Failure>()),
      );
    });
  });
}
