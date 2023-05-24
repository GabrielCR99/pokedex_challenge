import 'package:flutter/painting.dart';

enum PokemonType {
  normal('normal', Color(0xFFAAA67F)),
  fighting('fighting', Color(0xFFC12239)),
  flying('flying', Color(0xFFA891EC)),
  poison('poison', Color(0xFFA43E9E)),
  ground('ground', Color(0xFFDEC16B)),
  rock('rock', Color(0xFFB69E31)),
  bug('bug', Color(0xFFA7B723)),
  ghost('ghost', Color(0xFF70559B)),
  steel('steel', Color(0xFFB7B9D0)),
  fire('fire', Color(0xFFF57D31)),
  water('water', Color(0xFF6493EB)),
  grass('grass', Color(0xFF74CB48)),
  electric('electric', Color(0xFFF9CF30)),
  psychic('psychic', Color(0xFFFB5584)),
  ice('ice', Color(0xFF9AD6DF)),
  dragon('dragon', Color(0xFF7037FF)),
  dark('dark', Color(0xFF75574C)),
  fairy('fairy', Color(0xFFE69EAC)),
  unknown('unknown', Color(0xFF68A090)),
  shadow('shadow', Color(0xFF3D3D3D));

  final String name;
  final Color color;

  const PokemonType(this.name, this.color);

  static PokemonType parse(String name) =>
      values.firstWhere((element) => element.name == name);

  String get capitalizedName => name[0].toUpperCase() + name.substring(1);
}
