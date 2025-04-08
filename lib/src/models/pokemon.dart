import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart' show immutable;

@immutable
final class Pokemon extends Equatable {
  final String id;
  final String name;
  final String imageUrl;

  const Pokemon({required this.name, this.id = '', this.imageUrl = ''});

  Pokemon copyWith({required String id, required String imageUrl}) =>
      Pokemon(name: name, id: id, imageUrl: imageUrl);

  String get sanitizedId => '#${id.padLeft(3, '0')}';
  String get sanitzedName => name[0].toUpperCase() + name.substring(1);

  @override
  List<Object> get props => [id, name, imageUrl];
}
