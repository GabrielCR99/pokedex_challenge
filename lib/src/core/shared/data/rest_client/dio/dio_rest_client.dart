import 'dart:io';

import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'package:flutter/foundation.dart';

import '../../../../constants/constants.dart';
import '../../../../helpers/rest_client_helper.dart';
import '../../../../logger/app_logger.dart';
import '../rest_client.dart';
import '../rest_client_response.dart';
import 'interceptors/rest_client_log_interceptor.dart';

interface class DioRestClient implements RestClient {
  late final Dio _dio;

  final _defaultOptions = BaseOptions(
    connectTimeout: const Duration(seconds: 6),
    receiveTimeout: const Duration(seconds: 60),
    baseUrl: baseUrl,
    contentType: ContentType.json.mimeType,
  );

  DioRestClient({
    required AppLogger logger,
    BaseOptions? baseOptions,
    HttpClientAdapter? httpClientAdapter,
  }) {
    _dio = Dio(baseOptions ?? _defaultOptions)
      ..interceptors.addAll([
        if (kDebugMode)
          RestClientLogInterceptor(
            logger: logger,
            requestBody: true,
            responseBody: true,
          ),
      ])
      ..httpClientAdapter = httpClientAdapter ?? IOHttpClientAdapter();
  }

  @override
  Future<RestClientResponse<T>> get<T>(
    String path, {
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headers,
  }) async {
    try {
      final response = await _dio.get<T>(
        path,
        queryParameters: queryParameters,
        options: Options(headers: headers),
      );

      return _dioResponseConverter<T>(response);
    } on DioException catch (e, s) {
      return Error.throwWithStackTrace(getRestClientException(e), s);
    }
  }

  RestClientResponse<T> _dioResponseConverter<T>(Response<T> response) =>
      RestClientResponse<T>(
        data: response.data as T,
        statusCode: response.statusCode,
        statusMessage: response.statusMessage,
      );
}
