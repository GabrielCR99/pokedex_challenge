import 'package:mocktail/mocktail.dart';
import 'package:snapfi_mobile_challenge_pokedex_roveri/src/models/pokemon.dart';
import 'package:snapfi_mobile_challenge_pokedex_roveri/src/repositories/pokemon/pokemon_repository.dart';

const pokemonList = [
  Pokemon(name: 'bulbasaur'),
  Pokemon(name: 'charmander'),
  Pokemon(name: 'squirtle'),
];

final class MockPokemonRepository extends Mock implements PokemonRepository {
  void mockFetchPokemonSuccess() => when(
    () =>
        fetchPokemon(limit: any(named: 'limit'), offset: any(named: 'offset')),
  ).thenAnswer((_) async => pokemonList);
}
