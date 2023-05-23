import 'dart:convert';

import 'package:mocktail/mocktail.dart';
import 'package:snapfi_mobile_challenge_pokedex_roveri/src/core/shared/data/rest_client/rest_client_response.dart';

final class MockResponse<T> extends Mock implements RestClientResponse<T> {
  @override
  final T data;

  @override
  final int? statusCode;

  @override
  final String? statusMessage;

  MockResponse({required this.data, this.statusCode, this.statusMessage});

  @override
  String toString() {
    if (data is Map) {
      return jsonEncode(data);
    }

    return super.toString();
  }
}
