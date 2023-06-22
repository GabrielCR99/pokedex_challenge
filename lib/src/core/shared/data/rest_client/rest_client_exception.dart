import 'rest_client_response.dart';

interface class RestClientException implements Exception {
  final String message;
  final RestClientResponse<Object> response;
  final int? statusCode;

  const RestClientException({
    required this.message,
    required this.response,
    this.statusCode,
  });
}
