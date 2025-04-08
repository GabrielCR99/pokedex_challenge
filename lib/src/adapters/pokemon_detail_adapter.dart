import '../models/pokemon_detail.dart';
import '../models/pokemon_type.dart';
import 'pokemon_stat_adapter.dart';

extension type const PokemonDetailAdapter._(PokemonDetail _)
    implements PokemonDetail {
  String get sanitizedId => '#${id.toString().padLeft(3, '0')}';
  String get sanitzedName => name[0].toUpperCase() + name.substring(1);
  String get sanitizedDescription => speciesDescription
      .replaceAll('\n', ' ')
      .replaceAll('\f', ' ')
      .replaceAll('\r', ' ');

  static PokemonDetail fromJson(Map<String, dynamic> map) => switch (map) {
    {
      'abilities': final List<Object?> abilities,
      'stats': final List<Object?> stats,
      'types': final List<Object?> types,
      'name': final String name,
      'id': final int id,
      'height': final num height,
      'weight': final num weight,
      'sprites': {
        'other': {'official-artwork': {'front_default': final String imageUrl}},
      },
    } =>
      PokemonDetail(
        id: id,
        height: height.toDouble(),
        weight: weight.toDouble(),
        imageUrl: imageUrl,
        abilities: abilities
            .cast<Map<String, dynamic>>()
            .map((e) => (e['ability'] as Map)['name'] as String)
            .map(
              (e) => e[0].toUpperCase() + e.substring(1).replaceAll('-', ' '),
            ),
        stats: stats.cast<Map<String, dynamic>>().map(
          PokemonStatAdapter.fromMap,
        ),
        types: types.cast<Map<String, dynamic>>().map(
          (e) => PokemonType.parse(e['type']['name'] as String),
        ),
        name: name,
      ),
    _ => throw FormatException('Invalid PokemonDetail JSON: $map'),
  };
}
