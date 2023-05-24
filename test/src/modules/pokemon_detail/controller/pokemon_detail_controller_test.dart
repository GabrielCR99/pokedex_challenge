import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:snapfi_mobile_challenge_pokedex_roveri/src/modules/pokemon_detail/controller/pokemon_detail_controller.dart';

import '../../../services/mocks/mock_pokemon_detail_repository.dart';
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
    blocTest<PokemonDetailController, PokemonDetailState>(
      'emits [PokemonDetailLoading, PokemonDetailLoaded] when '
      'fetchPokemonDetail is called successfully',
      build: () => controller,
      setUp: () => mockService.mockFetchPokemonDetailSuccess(),
      seed: () => state,
      act: (controller) => controller.fetchPokemonDetail('bulbasaur'),
      expect: () => <PokemonDetailState>[
        state.copyWith(status: PokemonDetailStatus.loading),
        state.copyWith(
          status: PokemonDetailStatus.loaded,
          pokemonDetail: pokemonDetailList.first,
        ),
      ],
      verify: (_) =>
          verify(() => mockService.fetchPokemonDetail('bulbasaur')).called(1),
    );

    blocTest<PokemonDetailController, PokemonDetailState>(
      'emits [PokemonDetailLoading, PokemonDetailError] when fetchPokemonDetail'
      ' is called unsuccessfully',
      build: () => controller,
      setUp: () => mockService.mockFetchPokemonDetailFailure(),
      seed: () => state,
      act: (controller) => controller.fetchPokemonDetail('bulbasaur'),
      expect: () => <PokemonDetailState>[
        state.copyWith(status: PokemonDetailStatus.loading),
        state.copyWith(
          status: PokemonDetailStatus.error,
          errorMessage: 'Failure',
        ),
      ],
      verify: (_) =>
          verify(() => mockService.fetchPokemonDetail('bulbasaur')).called(1),
    );
  });

  group('Group test fetchNextPokemon', () {
    blocTest<PokemonDetailController, PokemonDetailState>(
      'emits [PokemonDetailLoading, PokemonDetailLoaded] when fetchNextPokemon'
      ' is called successfully',
      build: () => controller,
      setUp: () => mockService.mockFetchNextPokemonDetailSuccess(),
      seed: () => state.copyWith(
        status: PokemonDetailStatus.loaded,
        pokemonDetail: pokemonDetailList.first,
      ),
      act: (controller) => controller.fetchNextPokemon(),
      expect: () => <PokemonDetailState>[
        state.copyWith(
          status: PokemonDetailStatus.loading,
          pokemonDetail: pokemonDetailList.first,
        ),
        state.copyWith(
          status: PokemonDetailStatus.loaded,
          pokemonDetail: pokemonDetailList[1],
        ),
      ],
      verify: (_) =>
          verify(() => mockService.fetchNextOrPreviousPokemonDetail(offset: 1))
              .called(1),
    );

    blocTest<PokemonDetailController, PokemonDetailState>(
      'emits [PokemonDetailLoading, PokemonDetailError] when fetchNextPokemon'
      ' is called unsuccessfully',
      build: () => controller,
      setUp: () => mockService.mockFetchNextPokemonDetailFailure(),
      seed: () => state.copyWith(
        status: PokemonDetailStatus.loaded,
        pokemonDetail: pokemonDetailList.first,
      ),
      act: (controller) => controller.fetchNextPokemon(),
      expect: () => <PokemonDetailState>[
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
      verify: (_) =>
          verify(() => mockService.fetchNextOrPreviousPokemonDetail(offset: 1))
              .called(1),
    );
  });

  group('Group test fetchPreviousPokemon', () {
    blocTest<PokemonDetailController, PokemonDetailState>(
      'emits [PokemonDetailLoading, PokemonDetailLoaded] when '
      'fetchPreviousPokemon is called successfully',
      build: () => controller,
      setUp: () => mockService.mockFetchPreviousPokemonDetailSuccess(),
      seed: () => state.copyWith(
        status: PokemonDetailStatus.loaded,
        pokemonDetail: pokemonDetailList[1],
      ),
      act: (controller) => controller.fetchPreviousPokemon(),
      expect: () => <PokemonDetailState>[
        state.copyWith(
          status: PokemonDetailStatus.loading,
          pokemonDetail: pokemonDetailList[1],
        ),
        state.copyWith(
          status: PokemonDetailStatus.loaded,
          pokemonDetail: pokemonDetailList.first,
        ),
      ],
      verify: (_) =>
          verify(() => mockService.fetchNextOrPreviousPokemonDetail(offset: 0))
              .called(1),
    );

    blocTest<PokemonDetailController, PokemonDetailState>(
      'emits [PokemonDetailLoading, PokemonDetailError] when '
      'fetchPreviousPokemon is called unsuccessfully',
      build: () => controller,
      setUp: () => mockService.mockFetchPreviousPokemonDetailFailure(),
      seed: () => state.copyWith(
        status: PokemonDetailStatus.loaded,
        pokemonDetail: pokemonDetailList[1],
      ),
      act: (controller) => controller.fetchPreviousPokemon(),
      expect: () => <PokemonDetailState>[
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
      verify: (_) =>
          verify(() => mockService.fetchNextOrPreviousPokemonDetail(offset: 0))
              .called(1),
    );
  });
}
