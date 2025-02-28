import 'package:mocktail/mocktail.dart';
import 'package:snapfi_mobile_challenge_pokedex_roveri/src/modules/pokemon_detail/controller/pokemon_detail_controller.dart';
import 'package:test/test.dart';

import '../../../services/mocks/mock_pokemon_detail_repository.dart';
import '../../../shared/notifier_test.dart';
import '../mocks/mock_pokemon_detail_service.dart';

void main() {
  late PokemonDetailState state;
  late MockPokemonDetailService mockService;
  late PokemonDetailController controller;

  setUp(() {
    state = const PokemonDetailState.initial();
    mockService = MockPokemonDetailService();
    controller = PokemonDetailController(service: mockService);
  });

  group('Group test fetchPokemonDetail', () {
    notifierTest<PokemonDetailController, PokemonDetailState>(
      'emits [PokemonDetailLoading, PokemonDetailLoaded] when '
      'fetchPokemonDetail is called successfully',
      createController: () => controller,
      setUp: () => mockService.mockFetchPokemonDetailSuccess(),
      seed: () => state,
      act: (controller) => controller.fetchPokemonDetail('bulbasaur'),
      expectedValues:
          () => <PokemonDetailState>[
            state.copyWith(status: PokemonDetailStatus.loading),
            state.copyWith(
              status: PokemonDetailStatus.loaded,
              pokemonDetail: pokemonDetailList.first,
            ),
          ],
      verify:
          () => verify(
            () => mockService.fetchPokemonDetail('bulbasaur'),
          ).called(1),
    );

    notifierTest<PokemonDetailController, PokemonDetailState>(
      'emits [PokemonDetailLoading, PokemonDetailError] when fetchPokemonDetail'
      ' is called unsuccessfully',
      createController: () => controller,
      setUp: () => mockService.mockFetchPokemonDetailFailure(),
      seed: () => state,
      act: (controller) => controller.fetchPokemonDetail('bulbasaur'),
      expectedValues:
          () => <PokemonDetailState>[
            state.copyWith(status: PokemonDetailStatus.loading),
            state.copyWith(
              status: PokemonDetailStatus.error,
              errorMessage: 'Failure',
            ),
          ],
      verify:
          () => verify(
            () => mockService.fetchPokemonDetail('bulbasaur'),
          ).called(1),
    );
  });

  group('Group test fetchNextPokemon', () {
    notifierTest<PokemonDetailController, PokemonDetailState>(
      'emits [PokemonDetailLoading, PokemonDetailLoaded] when fetchNextPokemon'
      ' is called successfully',
      createController: () => controller,
      setUp: () => mockService.mockFetchNextPokemonDetailSuccess(),
      seed:
          () => state.copyWith(
            status: PokemonDetailStatus.loaded,
            pokemonDetail: pokemonDetailList.first,
          ),
      act: (controller) => controller.fetchNextPokemon(),
      expectedValues:
          () => <PokemonDetailState>[
            state.copyWith(
              status: PokemonDetailStatus.loading,
              pokemonDetail: pokemonDetailList.first,
            ),
            state.copyWith(
              status: PokemonDetailStatus.loaded,
              pokemonDetail: pokemonDetailList[1],
            ),
          ],
      verify:
          () => verify(
            () => mockService.fetchNextOrPreviousPokemonDetail(offset: 1),
          ).called(1),
    );

    notifierTest<PokemonDetailController, PokemonDetailState>(
      'emits [PokemonDetailLoading, PokemonDetailError] when fetchNextPokemon'
      ' is called unsuccessfully',
      createController: () => controller,
      setUp: () => mockService.mockFetchNextPokemonDetailFailure(),
      seed:
          () => state.copyWith(
            status: PokemonDetailStatus.loaded,
            pokemonDetail: pokemonDetailList.first,
          ),
      act: (controller) => controller.fetchNextPokemon(),
      expectedValues:
          () => <PokemonDetailState>[
            state.copyWith(
              status: PokemonDetailStatus.loading,
              pokemonDetail: pokemonDetailList.first,
            ),
            state.copyWith(
              status: PokemonDetailStatus.error,
              errorMessage: 'Failure',
              pokemonDetail: pokemonDetailList.first,
            ),
          ],
      verify:
          () => verify(
            () => mockService.fetchNextOrPreviousPokemonDetail(offset: 1),
          ).called(1),
    );
  });

  group('Group test fetchPreviousPokemon', () {
    notifierTest<PokemonDetailController, PokemonDetailState>(
      'emits [PokemonDetailLoading, PokemonDetailLoaded] when '
      'fetchPreviousPokemon is called successfully',
      createController: () => controller,
      setUp: () => mockService.mockFetchPreviousPokemonDetailSuccess(),
      seed:
          () => state.copyWith(
            status: PokemonDetailStatus.loaded,
            pokemonDetail: pokemonDetailList[1],
          ),
      act: (controller) => controller.fetchPreviousPokemon(),
      expectedValues:
          () => <PokemonDetailState>[
            state.copyWith(
              status: PokemonDetailStatus.loading,
              pokemonDetail: pokemonDetailList[1],
            ),
            state.copyWith(
              status: PokemonDetailStatus.loaded,
              pokemonDetail: pokemonDetailList.first,
            ),
          ],
      verify:
          () => verify(
            () => mockService.fetchNextOrPreviousPokemonDetail(offset: 0),
          ).called(1),
    );

    notifierTest<PokemonDetailController, PokemonDetailState>(
      'emits [PokemonDetailLoading, PokemonDetailError] when '
      'fetchPreviousPokemon is called unsuccessfully',
      createController: () => controller,
      setUp: () => mockService.mockFetchPreviousPokemonDetailFailure(),
      seed:
          () => state.copyWith(
            status: PokemonDetailStatus.loaded,
            pokemonDetail: pokemonDetailList[1],
          ),
      act: (controller) => controller.fetchPreviousPokemon(),
      expectedValues:
          () => <PokemonDetailState>[
            state.copyWith(
              status: PokemonDetailStatus.loading,
              pokemonDetail: pokemonDetailList[1],
            ),
            state.copyWith(
              status: PokemonDetailStatus.error,
              errorMessage: 'Failure',
              pokemonDetail: pokemonDetailList[1],
            ),
          ],
      verify:
          () => verify(
            () => mockService.fetchNextOrPreviousPokemonDetail(offset: 0),
          ).called(1),
    );
  });
}
