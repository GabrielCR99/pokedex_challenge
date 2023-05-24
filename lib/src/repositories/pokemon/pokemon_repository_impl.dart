import '../../core/exceptions/failure.dart';
import '../../core/shared/data/rest_client/rest_client.dart';
import '../../core/shared/data/rest_client/rest_client_exception.dart';
import '../../models/pokemon.dart';
import 'pokemon_repository.dart';

final class PokemonRepositoryImpl implements PokemonRepository {
  final RestClient _restClient;

  const PokemonRepositoryImpl({required RestClient restClient})
      : _restClient = restClient;

  @override
  Future<List<Pokemon>> fetchPokemon({
    required int limit,
    required int offset,
  }) async {
    try {
      final response = await _restClient.get<Map<String, dynamic>>(
        '/pokemon',
        queryParameters: {'limit': limit, 'offset': offset},
      );

      final iterablePokemon = (response.data!['results'] as List)
          .map((e) => Pokemon(name: (e as Map)['name'] as String));

      return iterablePokemon.toList();
    } on RestClientException catch (e, s) {
      Error.throwWithStackTrace(Failure(message: e.message), s);
    }
  }
}
