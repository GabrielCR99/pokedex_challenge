import '../models/pokemon.dart';

extension type const PokemonAdapter._(Pokemon _) {
  static Pokemon fromJson(Map<String, dynamic> map) => switch (map) {
    {'name': final String name} => Pokemon(name: name),
    _ => throw FormatException('Invalid Pokemon JSON: $map'),
  };
}
