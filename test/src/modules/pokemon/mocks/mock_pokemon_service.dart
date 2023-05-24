import 'package:mocktail/mocktail.dart';
import 'package:snapfi_mobile_challenge_pokedex_roveri/src/core/exceptions/failure.dart';
import 'package:snapfi_mobile_challenge_pokedex_roveri/src/models/pokemon.dart';
import 'package:snapfi_mobile_challenge_pokedex_roveri/src/services/pokemon/pokemon_service.dart';

const pokemonList = [
  Pokemon(name: 'bulbasaur'),
  Pokemon(name: 'charmander'),
  Pokemon(name: 'squirtle'),
];

final class MockPokemonService extends Mock implements PokemonService {
  void mockFetchPokemonSuccess() => when(
        () => fetchPokemon(
          limit: any(named: 'limit'),
          offset: any(named: 'offset'),
        ),
      ).thenAnswer((_) async => pokemonList);

  void mockFetchPokemonFailure() => when(
        () => fetchPokemon(
          limit: any(named: 'limit'),
          offset: any(named: 'offset'),
        ),
      ).thenThrow(const Failure(message: 'Failure'));
}
