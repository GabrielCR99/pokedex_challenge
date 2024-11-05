import 'package:dio/dio.dart';

import '../shared/data/rest_client/rest_client_exception.dart';
import '../shared/data/rest_client/rest_client_response.dart';

const _connectionError = 'Connection error, please try again later.';

RestClientException getRestClientException(DioException dioError) {
  final Response(:data, :statusCode, :statusMessage) =
      dioError.response ?? Response(requestOptions: RequestOptions());

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
