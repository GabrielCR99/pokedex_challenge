import 'package:mocktail/mocktail.dart';
import 'package:snapfi_mobile_challenge_pokedex_roveri/src/models/pokemon.dart';
import 'package:snapfi_mobile_challenge_pokedex_roveri/src/modules/pokemon/controllers/pokemon_controller.dart';
import 'package:test/test.dart';

import '../../../shared/notifier_test.dart';
import '../mocks/mock_pokemon_service.dart';

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
    notifierTest<PokemonController, PokemonState>(
      'emits [PokemonLoading, PokemonLoaded] when fetchPokemon is called '
      'successfully',
      createController: () => controller,
      setUp: () => mockService.mockFetchPokemonSuccess(),
      seed: () => state,
      act: (controller) => controller.fetchPokemon(),
      expectedValues: () => <PokemonState>[
        state.copyWith(status: PokemonStatus.loading),
        state.copyWith(
          status: PokemonStatus.loaded,
          pokemonList: pokemonList,
        ),
      ],
      verify: () =>
          verify(() => mockService.fetchPokemon(limit: limit, offset: 0))
              .called(1),
    );

    notifierTest<PokemonController, PokemonState>(
      'emits [PokemonLoading, PokemonError] when fetchPokemon is called '
      'unsuccessfully',
      createController: () => controller,
      setUp: () => mockService.mockFetchPokemonFailure(),
      seed: () => state,
      act: (controller) => controller.fetchPokemon(),
      expectedValues: () => <PokemonState>[
        state.copyWith(status: PokemonStatus.loading),
        state.copyWith(
          status: PokemonStatus.error,
          errorMessage: 'Failure',
        ),
      ],
      verify: () =>
          verify(() => mockService.fetchPokemon(limit: limit, offset: offset))
              .called(1),
    );
  });

  group('Group test fetchMorePokemon', () {
    notifierTest<PokemonController, PokemonState>(
      'emits [PokemonLoading, PokemonLoaded] when fetchMorePokemon is called '
      'successfully',
      createController: () => controller,
      setUp: () => mockService.mockFetchPokemonSuccess(),
      seed: () => state,
      act: (controller) => controller.fetchMorePokemon(),
      expectedValues: () => <PokemonState>[
        state.copyWith(status: PokemonStatus.loading),
        state.copyWith(status: PokemonStatus.loaded, pokemonList: pokemonList),
      ],
      verify: () =>
          verify(() => mockService.fetchPokemon(limit: limit, offset: offset))
              .called(1),
    );

    notifierTest<PokemonController, PokemonState>(
      'emits [PokemonLoading, PokemonError] when fetchMorePokemon is called '
      'unsuccessfully',
      createController: () => controller,
      setUp: () => mockService.mockFetchPokemonFailure(),
      seed: () => state,
      act: (controller) => controller.fetchMorePokemon(),
      expectedValues: () => <PokemonState>[
        state.copyWith(status: PokemonStatus.loading),
        state.copyWith(
          status: PokemonStatus.error,
          errorMessage: 'Failure',
        ),
      ],
      verify: () =>
          verify(() => mockService.fetchPokemon(limit: limit, offset: offset))
              .called(1),
    );
  });

  group('Group test filterPokemon', () {
    notifierTest<PokemonController, PokemonState>(
      'emits [PokemonLoaded] when filterPokemon is called',
      createController: () => controller,
      setUp: () => mockService.mockFetchPokemonSuccess(),
      seed: () => state,
      act: (controller) async {
        await controller.fetchPokemon();
        controller.filterPokemon('bulbasaur');
      },
      expectedValues: () => <PokemonState>[
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
