import 'dart:io';

import 'package:dio/dio.dart';
import 'package:http_mock_adapter/http_mock_adapter.dart';
import 'package:mocktail/mocktail.dart';
import 'package:snapfi_mobile_challenge_pokedex_roveri/src/core/logger/app_logger.dart';
import 'package:snapfi_mobile_challenge_pokedex_roveri/src/core/shared/data/rest_client/dio/dio_rest_client.dart';
import 'package:snapfi_mobile_challenge_pokedex_roveri/src/core/shared/data/rest_client/rest_client_exception.dart';
import 'package:test/test.dart';

final class MockAppLogger extends Mock implements AppLogger {}

void main() async {
  late DioRestClient restClient;
  late AppLogger logger;
  late DioAdapter adapter;
  final dio = Dio();

  setUp(() {
    logger = MockAppLogger();
    adapter = DioAdapter(dio: dio);
    restClient = DioRestClient(logger: logger, httpClientAdapter: adapter);
  });

  group(
    'Group test get',
    () {
      test('should return a RestClientResponse with data', () async {
        adapter.onGet(
          '/users',
          (server) => server.reply(
            HttpStatus.ok,
            const {'title': 'delectus aut autem'},
            statusMessage: 'OK',
          ),
        );

        final response = await restClient.get<Map<String, dynamic>>('/users');

        expect(response.data, const {'title': 'delectus aut autem'});
        expect(response.statusCode, HttpStatus.ok);
        expect(response.statusMessage, 'OK');
      });

      test(
        'should return a RestClientResponse with error',
        () {
          final dioError = DioError(
            requestOptions: RequestOptions(path: '/users'),
            response: Response<Map<String, dynamic>>(
              data: const {'error': 'Internal Server Error'},
              requestOptions: RequestOptions(path: '/users'),
              statusCode: HttpStatus.internalServerError,
              statusMessage: 'Not Found',
            ),
            type: DioErrorType.badResponse,
          );

          adapter.onGet(
            '/users',
            (server) => server.throws(HttpStatus.internalServerError, dioError),
          );

          expect(
            () => restClient.get<Map<String, dynamic>>('/users'),
            throwsA(
              isA<RestClientException>().having(
                (e) => e.response!.data,
                'response.data',
                const {'error': 'Internal Server Error'},
              ),
            ),
          );
          expect(
            () => restClient.get<Map<String, dynamic>>('/users'),
            throwsA(
              isA<RestClientException>().having(
                (e) => e.response!.statusCode,
                'response.statusCode',
                HttpStatus.internalServerError,
              ),
            ),
          );
          expect(
            () => restClient.get<Map<String, dynamic>>('/users'),
            throwsA(
              isA<RestClientException>().having(
                (e) => e.response!.statusMessage,
                'response.statusMessage',
                'Not Found',
              ),
            ),
          );
        },
      );
    },
  );
}
