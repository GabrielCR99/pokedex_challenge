final class Failure implements Exception {
  final String message;
  final int? statusCode;

  const Failure({required this.message, this.statusCode});
}
