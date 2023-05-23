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

  Pokemon copyWith({String? id, String? name, String? imageUrl}) => Pokemon(
        name: name ?? this.name,
        id: id ?? this.id,
        imageUrl: imageUrl ?? this.imageUrl,
      );

  factory Pokemon.fromJson(Map<String, dynamic> map) =>
      Pokemon(name: (map['name'] ?? '') as String);

  @override
  List<Object> get props => [id, name, imageUrl];
}
