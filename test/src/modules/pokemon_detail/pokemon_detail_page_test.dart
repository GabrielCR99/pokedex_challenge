import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:provider/provider.dart';
import 'package:snapfi_mobile_challenge_pokedex_roveri/src/core/logger/app_logger.dart';
import 'package:snapfi_mobile_challenge_pokedex_roveri/src/core/logger/app_logger_impl.dart';
import 'package:snapfi_mobile_challenge_pokedex_roveri/src/core/shared/data/rest_client/dio/dio_rest_client.dart';
import 'package:snapfi_mobile_challenge_pokedex_roveri/src/core/shared/data/rest_client/rest_client.dart';
import 'package:snapfi_mobile_challenge_pokedex_roveri/src/models/pokemon.dart';
import 'package:snapfi_mobile_challenge_pokedex_roveri/src/models/pokemon_detail.dart';
import 'package:snapfi_mobile_challenge_pokedex_roveri/src/models/pokemon_type.dart';
import 'package:snapfi_mobile_challenge_pokedex_roveri/src/modules/pokemon_detail/controller/pokemon_detail_controller.dart';
import 'package:snapfi_mobile_challenge_pokedex_roveri/src/modules/pokemon_detail/pokemon_detail_page.dart';

final class MockPokemonDetailController extends Mock
    implements PokemonDetailController {}

void main() {
  const pokemon = Pokemon(
    name: 'bulbasaur',
    id: '1',
    imageUrl: 'https://pokeapi.co/api/v2/pokemon/1/',
  );
  const bulbasaurDetail = PokemonDetail(
    id: 1,
    height: 1,
    weight: 1,
    imageUrl:
        'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/1.png',
    abilities: ['overgrow', 'chlorophyll'],
    stats: [(name: 'hp', value: 45)],
    types: [PokemonType.grass, PokemonType.poison],
    name: 'bulbasaur',
  );
  TestWidgetsFlutterBinding.ensureInitialized();

  late PokemonDetailController mockController;
  late PokemonDetailState state;

  setUpAll(() {
    mockController = MockPokemonDetailController();
    state = const PokemonDetailState.initial();
  });

  tearDown(() => mockController.dispose());

  testWidgets('pokemon detail page ...', (tester) async {
    when(
      () => mockController.value,
    ).thenReturn(state.copyWith(status: PokemonDetailStatus.loading));
    when(() => mockController.fetchPokemonDetail(pokemon.name)).thenAnswer((
      _,
    ) async {
      return;
    });

    await tester.pumpWidget(
      ScreenUtilInit(
        builder:
            (_, __) => MultiProvider(
              providers: [
                Provider<AppLogger>(
                  create: (_) => AppLoggerImpl(),
                  lazy: false,
                ),
                Provider<RestClient>(
                  create: (context) => DioRestClient(logger: context.read()),
                  lazy: false,
                ),
                ChangeNotifierProvider.value(
                  value: mockController..fetchPokemonDetail(pokemon.name),
                ),
              ],
              child: MaterialApp(
                onGenerateRoute:
                    (_) => MaterialPageRoute(
                      builder:
                          (context) => PokemonDetailPage(
                            pokemonDetailController: context.read(),
                          ),
                      settings: const RouteSettings(arguments: pokemon),
                    ),
              ),
            ),
        designSize: const Size(360, 640),
      ),
    );

    await tester.pump();
    expect(find.byKey(const Key('loading_pokemon_detail')), findsOneWidget);
  });

  testWidgets('pokemon detail page error ...', (tester) async {
    when(() => mockController.value).thenReturn(
      state.copyWith(status: PokemonDetailStatus.error, errorMessage: 'error'),
    );
    when(() => mockController.fetchPokemonDetail(pokemon.name)).thenAnswer((
      _,
    ) async {
      return;
    });

    await tester.pumpWidget(
      ScreenUtilInit(
        builder:
            (_, __) => MultiProvider(
              providers: [
                Provider<AppLogger>(
                  create: (_) => AppLoggerImpl(),
                  lazy: false,
                ),
                Provider<RestClient>(
                  create: (context) => DioRestClient(logger: context.read()),
                  lazy: false,
                ),
                ChangeNotifierProvider.value(
                  value: mockController..fetchPokemonDetail(pokemon.name),
                ),
              ],
              child: MaterialApp(
                onGenerateRoute:
                    (_) => MaterialPageRoute(
                      builder:
                          (context) => PokemonDetailPage(
                            pokemonDetailController: context.read(),
                          ),
                      settings: const RouteSettings(arguments: pokemon),
                    ),
              ),
            ),
        designSize: const Size(360, 640),
      ),
    );

    await tester.pump();
    expect(find.byKey(const Key('pokemon_detail_error')), findsOneWidget);
  });

  testWidgets('pokemon detail page loaded ...', (tester) async {
    when(() => mockController.value).thenReturn(
      state.copyWith(
        status: PokemonDetailStatus.loaded,
        pokemonDetail: bulbasaurDetail,
      ),
    );
    when(() => mockController.fetchPokemonDetail(pokemon.name)).thenAnswer((
      _,
    ) async {
      return;
    });

    await tester.pumpWidget(
      ScreenUtilInit(
        builder:
            (_, __) => MultiProvider(
              providers: [
                Provider<AppLogger>(
                  create: (_) => AppLoggerImpl(),
                  lazy: false,
                ),
                Provider<RestClient>(
                  create: (context) => DioRestClient(logger: context.read()),
                  lazy: false,
                ),
                ChangeNotifierProvider.value(
                  value: mockController..fetchPokemonDetail(pokemon.name),
                ),
              ],
              child: MaterialApp(
                onGenerateRoute:
                    (_) => MaterialPageRoute(
                      builder:
                          (context) => PokemonDetailPage(
                            pokemonDetailController: context.read(),
                          ),
                      settings: const RouteSettings(arguments: pokemon),
                    ),
              ),
            ),
        designSize: const Size(360, 640),
      ),
    );

    await tester.pump();
    expect(find.byKey(const Key('loaded_pokemon_detail')), findsOneWidget);
  });

  testWidgets('pokemon detail page try again button', (tester) async {
    when(() => mockController.value).thenReturn(
      state.copyWith(status: PokemonDetailStatus.error, errorMessage: 'error'),
    );
    when(() => mockController.fetchPokemonDetail(pokemon.name)).thenAnswer((
      _,
    ) async {
      return;
    });

    await tester.pumpWidget(
      ScreenUtilInit(
        builder:
            (_, __) => MultiProvider(
              providers: [
                Provider<AppLogger>(
                  create: (_) => AppLoggerImpl(),
                  lazy: false,
                ),
                Provider<RestClient>(
                  create: (context) => DioRestClient(logger: context.read()),
                  lazy: false,
                ),
                ChangeNotifierProvider.value(
                  value: mockController..fetchPokemonDetail(pokemon.name),
                ),
              ],
              child: MaterialApp(
                onGenerateRoute:
                    (_) => MaterialPageRoute(
                      builder:
                          (context) => PokemonDetailPage(
                            pokemonDetailController: context.read(),
                          ),
                      settings: const RouteSettings(arguments: pokemon),
                    ),
              ),
            ),
        designSize: const Size(360, 640),
      ),
    );

    await tester.pump();
    expect(find.byKey(const Key('retry_button')), findsOneWidget);
    await tester.tap(find.byKey(const Key('retry_button')));
    verify(() => mockController.fetchPokemonDetail(pokemon.name));
  });
}
