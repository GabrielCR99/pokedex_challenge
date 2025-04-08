import '../../adapters/pokemon_detail_adapter.dart';
import '../../core/exceptions/failure.dart';
import '../../core/shared/data/rest_client/rest_client.dart';
import '../../core/shared/data/rest_client/rest_client_exception.dart';
import '../../core/shared/data/rest_client/rest_client_response.dart';
import '../../models/pokemon_detail.dart';
import 'pokemon_detail_repository.dart';

final class PokemonDetailRepositoryImpl implements PokemonDetailRepository {
  final RestClient restClient;

  const PokemonDetailRepositoryImpl({required this.restClient});

  @override
  Future<PokemonDetail> fetchPokemonDetail(String name) async {
    try {
      final RestClientResponse(:data) = await restClient
          .get<Map<String, dynamic>>('/pokemon/$name');

      return PokemonDetailAdapter.fromJson(data!);
    } on RestClientException catch (e, s) {
      Error.throwWithStackTrace(Failure(message: e.message), s);
    }
  }

  @override
  Future<String> fetchPokemonSpecies(String name) async {
    try {
      final RestClientResponse(
        data: {'flavor_text_entries': List<Object?> response}!,
      ) = await restClient.get<Map<String, dynamic>>('/pokemon-species/$name');

      final flavorTextEntries =
          response
              .cast<Map<String, dynamic>>()
              .where((e) => e['language']['name'] == 'en')
              .toList();

      return flavorTextEntries.isNotEmpty
          ? flavorTextEntries.first['flavor_text'] as String
          : '';
    } on RestClientException catch (e, s) {
      Error.throwWithStackTrace(Failure(message: e.message), s);
    }
  }
}
