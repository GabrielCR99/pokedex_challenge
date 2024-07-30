import 'package:mocktail/mocktail.dart';
import 'package:snapfi_mobile_challenge_pokedex_roveri/src/core/shared/data/rest_client/dio/dio_rest_client.dart';

import 'mock_response.dart';
import 'mock_rest_client_exception.dart';

final class MockRestClient extends Mock implements DioRestClient {
  void mockGetSuccess<T>({
    required MockResponse<T> mockResponse,
    Map<String, dynamic>? queryParameters,
  }) =>
      when(
        () => get<T>(
          any(),
          queryParameters: queryParameters ?? any(named: 'queryParameters'),
        ),
      ).thenAnswer((_) async => mockResponse);

  void mockGetException<T extends Object>({
    MockRestClientException? mockException,
    Map<String, dynamic>? queryParameters,
  }) {
    final exception = _mockException(mockException);

    when<void>(
      () => get<T>(
        any(),
        queryParameters: queryParameters ?? any(named: 'queryParameters'),
      ),
    ).thenThrow(exception);
  }

  MockRestClientException _mockException(
    MockRestClientException? mockException,
  ) {
    var exception = mockException;

    if (exception == null) {
      exception = MockRestClientException();
      when<String>(() => exception!.message).thenReturn('Dio Error');
    }

    return exception;
  }
}
