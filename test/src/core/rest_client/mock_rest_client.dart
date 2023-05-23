import 'package:mocktail/mocktail.dart';
import 'package:snapfi_mobile_challenge_pokedex_roveri/src/core/shared/data/rest_client/dio/dio_rest_client.dart';

import 'mock_response.dart';
import 'mock_rest_client_exception.dart';

class MockRestClient<T extends Object> extends Mock implements DioRestClient {
  void mockGetSuccess({
    required MockResponse<T> mockResponse,
    Map<String, dynamic>? queryParameters,
  }) =>
      when(
        () => get<T>(
          any(),
          queryParameters: queryParameters ?? any(named: 'queryParameters'),
        ),
      ).thenAnswer((_) async => mockResponse);

  void mockGetException({
    MockRestClientException<T>? mockException,
    Map<String, dynamic>? queryParameters,
  }) {
    final exception = _mockException(mockException);

    when(
      () => get<T>(
        any(),
        queryParameters: queryParameters ?? any(named: 'queryParameters'),
      ),
    ).thenThrow(exception);
  }

  MockRestClientException<T> _mockException(
    MockRestClientException<T>? mockException,
  ) {
    var exception = mockException;

    if (exception == null) {
      exception = MockRestClientException();
      when(() => exception!.message).thenReturn('Dio Error');
    }

    return exception;
  }
}
