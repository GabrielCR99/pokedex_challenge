import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart' show immutable;

@immutable
final class Pokemon extends Equatable {
  final String id;
  final String name;
  final String imageUrl;

  const Pokemon({
    required this.name,
    this.id = '',
    this.imageUrl = '',
  });

  String get sanitizedId => '#${id.padLeft(3, '0')}';
  String get sanitzedName => name[0].toUpperCase() + name.substring(1);

  Pokemon copyWith({
    required String id,
    required String imageUrl,
    String? name,
  }) =>
      Pokemon(name: name ?? this.name, id: id, imageUrl: imageUrl);

  factory Pokemon.fromJson(Map<String, dynamic> map) =>
      Pokemon(name: (map['name'] ?? '') as String);

  @override
  List<Object> get props => [id, name, imageUrl];
}
