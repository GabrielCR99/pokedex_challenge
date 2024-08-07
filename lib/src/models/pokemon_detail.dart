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
  final Iterable<String> abilities;
  final Iterable<PokemonStat> stats;
  final Iterable<PokemonType> types;

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

  factory PokemonDetail.fromJson(Map<String, dynamic> map) => switch (map) {
        {
          'abilities': final List<Object?> abilities,
          'stats': final List<Object?> stats,
          'types': final List<Object?> types,
          'name': final String name,
          'id': final int id,
          'height': final num height,
          'weight': final num weight,
          'sprites': {
            'other': {
              'official-artwork': {'front_default': final String imageUrl}
            }
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
                  (e) =>
                      e[0].toUpperCase() + e.substring(1).replaceAll('-', ' '),
                ),
            stats: stats.cast<Map<String, dynamic>>().map(PokemonStat.fromMap),
            types: types
                .cast<Map<String, dynamic>>()
                .map((e) => PokemonType.parse(e['type']['name'] as String)),
            name: name,
          ),
        _ => throw FormatException('Invalid PokemonDetail JSON: $map'),
      };

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
