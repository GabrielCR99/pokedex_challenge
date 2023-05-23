import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart' show immutable;

@immutable
final class PokemonStat extends Equatable {
  final String name;
  final int value;

  const PokemonStat({required this.name, required this.value});

  factory PokemonStat.fromMap(Map<String, dynamic> map) {
    return PokemonStat(
      name: ((map['stat'] as Map)['name'] ?? '') as String,
      value: (map['base_stat'] ?? 0) as int,
    );
  }

  @override
  List<Object?> get props => [name, value];
}
