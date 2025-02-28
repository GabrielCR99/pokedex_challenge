import 'package:mocktail/mocktail.dart';
import 'package:snapfi_mobile_challenge_pokedex_roveri/src/core/exceptions/failure.dart';
import 'package:snapfi_mobile_challenge_pokedex_roveri/src/services/pokemon_detail/pokemon_detail_service.dart';

import '../../../services/mocks/mock_pokemon_detail_repository.dart';

final class MockPokemonDetailService extends Mock
    implements PokemonDetailService {
  void mockFetchPokemonDetailSuccess() => when(
    () => fetchPokemonDetail(any()),
  ).thenAnswer((_) async => pokemonDetailList.first);
  void mockFetchPokemonDetailFailure() => when(
    () => fetchPokemonDetail(any()),
  ).thenThrow(const Failure(message: 'Failure'));
  void mockFetchPokemonSpeciesSuccess() =>
      when(() => fetchPokemonSpecies(any())).thenAnswer((_) async => 'species');
  void mockFetchPokemonSpeciesFailure() => when(
    () => fetchPokemonSpecies(any()),
  ).thenThrow(const Failure(message: 'Failure'));
  void mockFetchNextPokemonDetailSuccess() => when(
    () => fetchNextOrPreviousPokemonDetail(offset: any(named: 'offset')),
  ).thenAnswer((_) async => pokemonDetailList[1]);
  void mockFetchNextPokemonDetailFailure() => when(
    () => fetchNextOrPreviousPokemonDetail(offset: any(named: 'offset')),
  ).thenThrow(const Failure(message: 'Failure'));
  void mockFetchPreviousPokemonDetailSuccess() => when(
    () => fetchNextOrPreviousPokemonDetail(offset: any(named: 'offset')),
  ).thenAnswer((_) async => pokemonDetailList.first);
  void mockFetchPreviousPokemonDetailFailure() => when(
    () => fetchNextOrPreviousPokemonDetail(offset: any(named: 'offset')),
  ).thenThrow(const Failure(message: 'Failure'));
}
