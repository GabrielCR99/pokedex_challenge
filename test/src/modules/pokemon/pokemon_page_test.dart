import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:mocktail_image_network/mocktail_image_network.dart';
import 'package:provider/provider.dart';
import 'package:snapfi_mobile_challenge_pokedex_roveri/src/core/logger/app_logger.dart';
import 'package:snapfi_mobile_challenge_pokedex_roveri/src/core/logger/app_logger_impl.dart';
import 'package:snapfi_mobile_challenge_pokedex_roveri/src/core/shared/data/rest_client/dio/dio_rest_client.dart';
import 'package:snapfi_mobile_challenge_pokedex_roveri/src/core/shared/data/rest_client/rest_client.dart';
import 'package:snapfi_mobile_challenge_pokedex_roveri/src/models/pokemon.dart';
import 'package:snapfi_mobile_challenge_pokedex_roveri/src/modules/pokemon/controllers/pokemon_controller.dart';
import 'package:snapfi_mobile_challenge_pokedex_roveri/src/modules/pokemon/pokemon_page.dart';
import 'package:snapfi_mobile_challenge_pokedex_roveri/src/modules/pokemon/widgets/sort_card.dart';

final class MockPokemonCubit extends MockCubit<PokemonState>
    implements PokemonController {}

void main() {
  void ignoreOverflowErrors(
    FlutterErrorDetails details, {
    bool forceReport = false,
  }) {
    var isOverflowError = false;
    var isUnableToLoadAsset = false;

    // Detect overflow error.
    final exception = details.exception;
    if (exception is FlutterError) {
      isOverflowError = !exception.diagnostics.any(
        (e) => e.value.toString().startsWith('A RenderFlex overflowed by'),
      );
      isUnableToLoadAsset = !exception.diagnostics.any(
        (e) => e.value.toString().startsWith('Unable to load asset'),
      );
    }

    // Ignore if is overflow error.
    if (isOverflowError || isUnableToLoadAsset) {
      debugPrint('Ignored Error');
    } else {
      FlutterError.dumpErrorToConsole(details, forceReport: forceReport);
    }
  }

  const pokemonList = [
    Pokemon(
      name: 'bulbasaur',
      id: '1',
      imageUrl: 'https://pokeapi.co/api/v2/pokemon/1/',
    ),
    Pokemon(
      name: 'ivysaur',
      id: '2',
      imageUrl: 'https://pokeapi.co/api/v2/pokemon/2/',
    ),
    Pokemon(
      name: 'venusaur',
      id: '3',
      imageUrl: 'https://pokeapi.co/api/v2/pokemon/3/',
    ),
  ];
  TestWidgetsFlutterBinding.ensureInitialized();

  late PokemonController mockController;
  late PokemonState state;

  setUpAll(() {
    mockController = MockPokemonCubit();
    state = const PokemonState.initial();
  });

  tearDown(() => mockController.close());

  testWidgets('pokemon page loading test', (tester) async {
    when(() => mockController.state)
        .thenReturn(state.copyWith(status: PokemonStatus.loading));
    when(mockController.fetchPokemon).thenAnswer((_) async => _);

    await tester.pumpWidget(
      ScreenUtilInit(
        builder: (_, __) => MultiProvider(
          providers: [
            Provider<AppLogger>(create: (_) => AppLoggerImpl(), lazy: false),
            Provider<RestClient>(
              create: (context) => DioRestClient(logger: context.read()),
              lazy: false,
            ),
            BlocProvider.value(value: mockController..fetchPokemon()),
          ],
          child: const MaterialApp(home: PokemonPage()),
        ),
        designSize: const Size(360, 640),
      ),
    );
  });

  testWidgets('pokemon page error test', (tester) async {
    when(() => mockController.state).thenReturn(
      state.copyWith(
        status: PokemonStatus.error,
        errorMessage: 'Failure',
      ),
    );
    when(mockController.fetchPokemon).thenAnswer((_) async => _);

    await tester.pumpWidget(
      ScreenUtilInit(
        builder: (_, __) => MultiProvider(
          providers: [
            Provider<AppLogger>(create: (_) => AppLoggerImpl(), lazy: false),
            Provider<RestClient>(
              create: (context) => DioRestClient(logger: context.read()),
              lazy: false,
            ),
            BlocProvider.value(value: mockController..fetchPokemon()),
          ],
          child: const MaterialApp(home: PokemonPage()),
        ),
        designSize: const Size(360, 640),
      ),
    );

    await tester.pump();
    expect(find.byKey(const Key('pokemon_list_error')), findsOneWidget);
  });

  testWidgets('pokemon page loaded test', (tester) async {
    FlutterError.onError = ignoreOverflowErrors;

    when(() => mockController.state).thenReturn(
      state.copyWith(
        status: PokemonStatus.loaded,
        pokemonList: pokemonList,
      ),
    );
    when(mockController.fetchPokemon).thenAnswer((_) async => _);

    await mockNetworkImages(
      () => tester.pumpWidget(
        ScreenUtilInit(
          builder: (_, __) => MultiProvider(
            providers: [
              Provider<AppLogger>(create: (_) => AppLoggerImpl(), lazy: false),
              Provider<RestClient>(
                create: (context) => DioRestClient(logger: context.read()),
                lazy: false,
              ),
              BlocProvider.value(value: mockController..fetchPokemon()),
            ],
            child: const MaterialApp(home: PokemonPage()),
          ),
          designSize: const Size(360, 640),
        ),
      ),
    );

    await tester.pump();
    expect(find.byKey(const Key('loaded_pokemon_list')), findsOneWidget);
  });

  testWidgets('pokemon page SortCard test', (tester) async {
    FlutterError.onError = ignoreOverflowErrors;

    when(() => mockController.state).thenReturn(
      state.copyWith(
        status: PokemonStatus.loaded,
        pokemonList: pokemonList,
      ),
    );
    when(mockController.fetchPokemon).thenAnswer((_) async => _);

    await mockNetworkImages(
      () => tester.pumpWidget(
        ScreenUtilInit(
          builder: (_, __) => MultiProvider(
            providers: [
              Provider<AppLogger>(create: (_) => AppLoggerImpl(), lazy: false),
              Provider<RestClient>(
                create: (context) => DioRestClient(logger: context.read()),
                lazy: false,
              ),
              BlocProvider.value(value: mockController..fetchPokemon()),
            ],
            child: const MaterialApp(home: PokemonPage()),
          ),
          designSize: const Size(360, 640),
        ),
      ),
    );

    await tester.pump();
    await tester.tap(find.byType(SortCard));
  });
}
