import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:snapfi_mobile_challenge_pokedex_roveri/src/models/pokemon.dart';
import 'package:snapfi_mobile_challenge_pokedex_roveri/src/modules/pokemon/controllers/pokemon_controller.dart';

import '../mocks/mock_faq_service.dart';

void main() {
  const limit = 20;
  const offset = 0;
  const bulbasaur = Pokemon(name: 'bulbasaur');

  late PokemonState state;
  late MockPokemonService mockService;
  late PokemonController controller;

  setUp(() {
    state = const PokemonState.initial();
    mockService = MockPokemonService();
    controller = PokemonController(service: mockService);
  });

  group('Group test fetchPokemon', () {
    blocTest<PokemonController, PokemonState>(
      'emits [PokemonLoading, PokemonLoaded] when fetchPokemon is called '
      'successfully',
      build: () => controller,
      setUp: () => mockService.mockFetchPokemonSuccess(),
      seed: () => state,
      act: (controller) => controller.fetchPokemon(),
      expect: () => <PokemonState>[
        state.copyWith(status: PokemonStatus.loading),
        state.copyWith(
          status: PokemonStatus.loaded,
          pokemonList: pokemonList,
        ),
      ],
      verify: (_) =>
          verify(() => mockService.fetchPokemon(limit: limit, offset: 0))
              .called(1),
    );

    blocTest<PokemonController, PokemonState>(
      'emits [PokemonLoading, PokemonError] when fetchPokemon is called '
      'unsuccessfully',
      build: () => controller,
      setUp: () => mockService.mockFetchPokemonFailure(),
      seed: () => state,
      act: (controller) => controller.fetchPokemon(),
      expect: () => <PokemonState>[
        state.copyWith(status: PokemonStatus.loading),
        state.copyWith(
          status: PokemonStatus.error,
          errorMessage: 'Failure',
        ),
      ],
      verify: (_) =>
          verify(() => mockService.fetchPokemon(limit: limit, offset: offset))
              .called(1),
    );
  });

  group('Group test fetchMorePokemon', () {
    blocTest<PokemonController, PokemonState>(
      'emits [PokemonLoading, PokemonLoaded] when fetchMorePokemon is called '
      'successfully',
      build: () => controller,
      setUp: () => mockService.mockFetchPokemonSuccess(),
      seed: () => state,
      act: (controller) => controller.fetchMorePokemon(),
      expect: () => <PokemonState>[
        state.copyWith(status: PokemonStatus.loading),
        state.copyWith(status: PokemonStatus.loaded, pokemonList: pokemonList),
      ],
      verify: (_) =>
          verify(() => mockService.fetchPokemon(limit: limit, offset: offset))
              .called(1),
    );

    blocTest<PokemonController, PokemonState>(
      'emits [PokemonLoading, PokemonError] when fetchMorePokemon is called '
      'unsuccessfully',
      build: () => controller,
      setUp: () => mockService.mockFetchPokemonFailure(),
      seed: () => state,
      act: (controller) => controller.fetchMorePokemon(),
      expect: () => <PokemonState>[
        state.copyWith(status: PokemonStatus.loading),
        state.copyWith(
          status: PokemonStatus.error,
          errorMessage: 'Failure',
        ),
      ],
      verify: (_) =>
          verify(() => mockService.fetchPokemon(limit: limit, offset: offset))
              .called(1),
    );
  });

  group('Group test filterPokemon', () {
    blocTest<PokemonController, PokemonState>(
      'emits [PokemonLoaded] when filterPokemon is called',
      build: () => controller,
      setUp: () => mockService.mockFetchPokemonSuccess(),
      seed: () => state,
      act: (controller) async {
        await controller.fetchPokemon();
        controller.filterPokemon('bulbasaur');
      },
      expect: () => <PokemonState>[
        state.copyWith(status: PokemonStatus.loading),
        state.copyWith(
          status: PokemonStatus.loaded,
          pokemonList: pokemonList,
        ),
        state.copyWith(
          status: PokemonStatus.loaded,
          pokemonList: [bulbasaur],
          searchQuery: 'bulbasaur',
        ),
      ],
    );
  });
}
