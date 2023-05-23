import 'rest_client_response.dart';

class RestClientException implements Exception {
  final String message;
  final RestClientResponse<Object>? response;
  final int? statusCode;

  const RestClientException({
    required this.message,
    this.response,
    this.statusCode,
  });
}
