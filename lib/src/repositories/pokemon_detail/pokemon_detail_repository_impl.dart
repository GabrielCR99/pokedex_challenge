import '../../core/shared/data/rest_client/rest_client.dart';
import '../../core/shared/data/rest_client/rest_client_exception.dart';
import '../../core/shared/domain/failures/failure.dart';
import '../../models/pokemon_detail.dart';
import 'pokemon_detail_repository.dart';

final class PokemonDetailRepositoryImpl implements PokemonDetailRepository {
  final RestClient _restClient;

  const PokemonDetailRepositoryImpl({required RestClient restClient})
      : _restClient = restClient;

  @override
  Future<PokemonDetail> fetchPokemonDetail(String name) async {
    try {
      final response =
          await _restClient.get<Map<String, dynamic>>('/pokemon/$name');

      return PokemonDetail.fromJson(response.data!);
    } on RestClientException catch (e, s) {
      Error.throwWithStackTrace(Failure(message: e.message), s);
    }
  }

  @override
  Future<String> fetchPokemonSpecies(String name) async {
    try {
      final response =
          await _restClient.get<Map<String, dynamic>>('/pokemon-species/$name');

      final flavorTextEntries = (response.data!['flavor_text_entries'] as List)
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
