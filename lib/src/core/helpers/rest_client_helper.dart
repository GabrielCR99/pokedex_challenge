import 'package:dio/dio.dart';

import '../shared/data/rest_client/rest_client_exception.dart';
import '../shared/data/rest_client/rest_client_response.dart';

const _connectionError =
    'Não foi possível obter informações da aplicação. Favor verificar a conexão'
    ' e tentar novamente.';

RestClientException getRestClientException(DioException dioError) {
  final Response(:data, :statusCode, :statusMessage) =
      dioError.response! as Response<Map<String, dynamic>>;

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
}
