import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart' show immutable;

import 'pokemon_stat.dart';
import 'pokemon_type.dart';

@immutable
final class PokemonDetail extends Equatable {
  const PokemonDetail({
    required this.id,
    required this.height,
    required this.weight,
    required this.imageUrl,
    required this.abilities,
    required this.stats,
    required this.types,
    required this.name,
    this.speciesDescription = '',
  });

  const PokemonDetail.empty()
    : id = 0,
      height = 0,
      weight = 0,
      imageUrl = '',
      abilities = const [],
      stats = const [],
      types = const [],
      name = '',
      speciesDescription = '';

  final int id;
  final double height;
  final double weight;
  final String imageUrl;
  final String speciesDescription;
  final String name;
  final Iterable<String> abilities;
  final Iterable<PokemonStat> stats;
  final Iterable<PokemonType> types;

  PokemonDetail copyWith({required String speciesDescription}) => PokemonDetail(
    id: id,
    height: height,
    weight: weight,
    imageUrl: imageUrl,
    abilities: abilities,
    stats: stats,
    types: types,
    name: name,
    speciesDescription: speciesDescription,
  );

  @override
  List<Object?> get props => [
    id,
    height,
    weight,
    imageUrl,
    speciesDescription,
    abilities,
    stats,
    name,
    types,
  ];
}
