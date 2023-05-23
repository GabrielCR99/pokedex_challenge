import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart' show immutable;

import 'pokemon_stat.dart';

@immutable
final class PokemonDetail extends Equatable {
  final int id;
  final int height;
  final int weight;
  final String imageUrl;
  final String speciesDescription;
  final List<String> moves;
  final List<PokemonStat> stats;

  const PokemonDetail({
    required this.id,
    required this.height,
    required this.weight,
    required this.imageUrl,
    required this.moves,
    required this.stats,
    this.speciesDescription = '',
  });

  PokemonDetail copyWith({
    int? id,
    int? height,
    int? weight,
    String? imageUrl,
    String? speciesDescription,
    List<String>? moves,
    List<PokemonStat>? stats,
  }) =>
      PokemonDetail(
        id: id ?? this.id,
        height: height ?? this.height,
        weight: weight ?? this.weight,
        imageUrl: imageUrl ?? this.imageUrl,
        moves: moves ?? this.moves,
        stats: stats ?? this.stats,
        speciesDescription: speciesDescription ?? this.speciesDescription,
      );

  factory PokemonDetail.fromJson(Map<String, dynamic> map) {
    final stats =
        List<Object?>.of((map['stats'] ?? const <String>[]) as List<Object?>);

    return PokemonDetail(
      id: (map['id'] ?? 0) as int,
      height: (map['height'] ?? 0) as int,
      weight: (map['weight'] ?? 0) as int,
      imageUrl: (map['sprites']['other']['official-artwork']['front_default'] ??
          '') as String,
      moves: List<Object?>.of(
        (map['moves'] ?? const <String>[]) as List<Object?>,
      ).map((e) => (e! as Map)['move']['name'] as String).take(2).toList(),
      stats: stats
          .map((e) => PokemonStat.fromMap(e! as Map<String, dynamic>))
          .toList(),
    );
  }

  @override
  List<Object?> get props =>
      [id, height, weight, imageUrl, speciesDescription, moves, stats];
}
