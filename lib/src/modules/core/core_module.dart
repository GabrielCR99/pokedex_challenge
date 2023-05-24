import 'package:provider/provider.dart';

import '../../core/logger/app_logger.dart';
import '../../core/logger/app_logger_impl.dart';
import '../../core/shared/data/rest_client/dio/dio_rest_client.dart';
import '../../core/shared/data/rest_client/rest_client.dart';
import '../../repositories/pokemon/pokemon_repository.dart';
import '../../repositories/pokemon/pokemon_repository_impl.dart';
import '../../repositories/pokemon_detail/pokemon_detail_repository.dart';
import '../../repositories/pokemon_detail/pokemon_detail_repository_impl.dart';
import '../../services/pokemon/pokemon_service.dart';
import '../../services/pokemon/pokemon_service_impl.dart';
import '../../services/pokemon_detail/pokemon_detail_service.dart';
import '../../services/pokemon_detail/pokemon_detail_service_impl.dart';

class CoreModule extends MultiProvider {
  CoreModule({super.key})
      : super(
          providers: [
            Provider<AppLogger>(create: (_) => AppLoggerImpl(), lazy: false),
            Provider<RestClient>(
              create: (context) => DioRestClient(logger: context.read()),
              lazy: false,
            ),
            Provider<PokemonRepository>(
              create: (context) =>
                  PokemonRepositoryImpl(restClient: context.read()),
              lazy: true,
            ),
            Provider<PokemonDetailRepository>(
              create: (context) =>
                  PokemonDetailRepositoryImpl(restClient: context.read()),
              lazy: true,
            ),
            Provider<PokemonService>(
              create: (context) => PokemonServiceImpl(
                pokemonRepository: context.read(),
                pokemonDetailRepository: context.read(),
              ),
              lazy: true,
            ),
            Provider<PokemonDetailService>(
              create: (context) => PokemonDetailServiceImpl(
                repository: context.read(),
                pokemonRepository: context.read(),
              ),
              lazy: true,
            ),
          ],
        );
}
