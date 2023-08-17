import '../../core/exceptions/failure.dart';
import '../../core/shared/data/rest_client/rest_client.dart';
import '../../core/shared/data/rest_client/rest_client_exception.dart';
import '../../core/shared/data/rest_client/rest_client_response.dart';
import '../../models/pokemon.dart';
import 'pokemon_repository.dart';

final class PokemonRepositoryImpl implements PokemonRepository {
  final RestClient _restClient;

  const PokemonRepositoryImpl({required RestClient restClient})
      : _restClient = restClient;

  @override
  Future<Iterable<Pokemon>> fetchPokemon({
    required int limit,
    required int offset,
  }) async {
    try {
      final RestClientResponse(:data) =
          await _restClient.get<Map<String, dynamic>>(
        '/pokemon',
        queryParameters: {'limit': limit, 'offset': offset},
      );

      return (data!['results'] as List)
          .map((e) => Pokemon(name: (e as Map)['name'] as String));
    } on RestClientException catch (e, s) {
      Error.throwWithStackTrace(Failure(message: e.message), s);
    }
  }
}
