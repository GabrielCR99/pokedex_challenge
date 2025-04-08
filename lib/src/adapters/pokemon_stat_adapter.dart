import '../models/pokemon_stat.dart';

extension type const PokemonStatAdapter._(PokemonStat _) {
  static PokemonStat fromMap(Map<String, dynamic> json) => switch (json) {
    {'stat': {'name': final String name}, 'base_stat': final int value} => (
      name: name,
      value: value,
    ),
    _ => throw const FormatException('Invalid PokemonStat JSON'),
  };
}
