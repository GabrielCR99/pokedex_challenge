import 'package:dio/dio.dart';

import '../shared/data/rest_client/rest_client_exception.dart';
import '../shared/data/rest_client/rest_client_response.dart';

const _connectionError =
    'Não foi possível obter informações da aplicação. Favor verificar a conexão'
    ' e tentar novamente.';
const _unexpectedError = 'Ocorreu um erro inesperado';

RestClientException getRestClientException(DioException dioError) {
  try {
    final response = dioError.response;
    final statusCode = response?.statusCode;
    final statusMessage = response?.statusMessage;
    final data = response?.data as Map<String, dynamic>?;

    if (dioError.type != DioExceptionType.unknown) {
      return RestClientException(
        message: _connectionError,
        response: RestClientResponse(
          data: data,
          statusCode: statusCode,
          statusMessage: statusMessage,
        ),
        statusCode: statusCode,
      );
    }

    return RestClientException(
      message: data is! String ? data!['message'] as String : _connectionError,
      response: RestClientResponse(
        data: data,
        statusCode: statusCode,
        statusMessage: statusMessage,
      ),
      statusCode: statusCode,
    );
  } catch (_) {
    return const RestClientException(message: _unexpectedError);
  }
}
