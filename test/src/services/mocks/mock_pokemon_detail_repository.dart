import 'package:mocktail/mocktail.dart';
import 'package:snapfi_mobile_challenge_pokedex_roveri/src/models/pokemon_detail.dart';
import 'package:snapfi_mobile_challenge_pokedex_roveri/src/repositories/pokemon_detail/pokemon_detail_repository.dart';

const pokemonDetailList = [
  PokemonDetail(
    id: 1,
    height: 1,
    weight: 1,
    imageUrl: 'https://example.com/bulbasaur.png',
    abilities: [],
    stats: [],
    types: [],
    name: 'bulbasaur',
  ),
  PokemonDetail(
    id: 2,
    height: 1,
    weight: 1,
    imageUrl: '',
    abilities: [],
    stats: [],
    types: [],
    name: 'ivysaur',
  ),
  PokemonDetail(
    id: 3,
    height: 1,
    weight: 1,
    imageUrl: '',
    abilities: [],
    stats: [],
    types: [],
    name: 'venusaur',
  ),
  PokemonDetail(
    id: 4,
    height: 1,
    weight: 1,
    imageUrl: 'https://example.com/charmander.png',
    abilities: [],
    stats: [],
    types: [],
    name: 'charmander',
  ),
  PokemonDetail(
    id: 7,
    height: 1,
    weight: 1,
    imageUrl: 'https://example.com/squirtle.png',
    abilities: [],
    stats: [],
    types: [],
    name: 'squirtle',
  ),
];

final class MockPokemonDetailRepository extends Mock
    implements PokemonDetailRepository {
  void mockFetchPokemonDetailSuccess() => when(() => fetchPokemonDetail(any()))
      .thenAnswer((_) async => pokemonDetailList.first);
  void mockFetchPokemonSpeciesSuccess() =>
      when(() => fetchPokemonSpecies(any())).thenAnswer((_) async => 'species');
}
