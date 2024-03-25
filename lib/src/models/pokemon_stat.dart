import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart' show immutable;

@immutable
final class PokemonStat extends Equatable {
  final String name;
  final int value;

  const PokemonStat({required this.name, required this.value});

  factory PokemonStat.fromMap(Map<String, dynamic> json) => switch (json) {
        {'stat': {'name': final String name}, 'base_stat': final int value} =>
          PokemonStat(name: name, value: value),
        _ => throw const FormatException('Invalid PokemonStat JSON'),
      };

  @override
  List<Object?> get props => [name, value];
}
