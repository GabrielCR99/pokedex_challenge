import 'dart:convert';
import 'dart:isolate';

import '../../core/exceptions/failure.dart';
import '../../core/shared/data/rest_client/rest_client.dart';
import '../../core/shared/data/rest_client/rest_client_exception.dart';
import '../../core/shared/data/rest_client/rest_client_response.dart';
import '../../models/pokemon.dart';
import 'pokemon_repository.dart';

final class PokemonRepositoryImpl implements PokemonRepository {
  final RestClient restClient;

  const PokemonRepositoryImpl({required this.restClient});

  @override
  Future<List<Pokemon>> fetchPokemon({
    required int limit,
    required int offset,
  }) async {
    try {
      final RestClientResponse(:data) = await restClient.get<String>(
        '/pokemon',
        queryParameters: {'limit': limit, 'offset': offset},
      );

      final results = await Isolate.run(
        () => jsonDecode(data!)['results'] as List<Object?>,
      );

      final iterablePokemon =
          results
              .map((e) => Pokemon(name: (e! as Map)['name'] as String))
              .toList();

      return iterablePokemon;
    } on RestClientException catch (e, s) {
      Error.throwWithStackTrace(Failure(message: e.message), s);
    }
  }
}
