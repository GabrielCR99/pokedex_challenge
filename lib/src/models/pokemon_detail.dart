import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart' show immutable;

import 'pokemon_stat.dart';
import 'pokemon_type.dart';

@immutable
final class PokemonDetail extends Equatable {
  final int id;
  final double height;
  final double weight;
  final String imageUrl;
  final String speciesDescription;
  final String name;
  final List<String> abilities;
  final List<PokemonStat> stats;
  final List<PokemonType> types;

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

  String get sanitizedId => '#${id.toString().padLeft(3, '0')}';
  String get sanitzedName => name[0].toUpperCase() + name.substring(1);
  String get sanitizedDescription => speciesDescription
      .replaceAll('\n', ' ')
      .replaceAll('\f', ' ')
      .replaceAll('\r', ' ');

  PokemonDetail copyWith({
    required String speciesDescription,
    int? id,
    double? height,
    double? weight,
    String? imageUrl,
    List<String>? abilities,
    List<PokemonStat>? stats,
    List<PokemonType>? types,
    String? name,
  }) =>
      PokemonDetail(
        id: id ?? this.id,
        height: height ?? this.height,
        weight: weight ?? this.weight,
        imageUrl: imageUrl ?? this.imageUrl,
        abilities: abilities ?? this.abilities,
        stats: stats ?? this.stats,
        types: types ?? this.types,
        name: name ?? this.name,
        speciesDescription: speciesDescription,
      );

  factory PokemonDetail.fromJson(Map<String, dynamic> map) {
    final abilities = List<Object?>.of(
      (map['abilities'] ?? const <String>[]) as List<Object?>,
    );
    final capitalizedAbilities = abilities
        .map((e) => ((e! as Map)['ability'] as Map)['name'] as String)
        .map((e) => e[0].toUpperCase() + e.substring(1).replaceAll('-', ' '))
        .toList();

    final stats =
        List<Object?>.of((map['stats'] ?? const <String>[]) as List<Object?>);
    final types =
        List<Object?>.of((map['types'] ?? const <String>[]) as List<Object?>)
            .cast<Map<String, dynamic>>();

    return PokemonDetail(
      id: (map['id'] ?? 0) as int,
      height: ((map['height'] / 10) ?? 0) as double,
      weight: ((map['weight'] / 10) ?? 0) as double,
      imageUrl: (map['sprites']['other']['official-artwork']['front_default'] ??
          '') as String,
      abilities: capitalizedAbilities,
      stats: stats
          .map((e) => PokemonStat.fromMap(e! as Map<String, dynamic>))
          .toList(),
      types: types
          .map((e) => PokemonType.parse(e['type']['name'] as String))
          .toList(),
      name: (map['name'] ?? '') as String,
    );
  }

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
