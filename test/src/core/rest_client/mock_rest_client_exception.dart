import 'package:mocktail/mocktail.dart';
import 'package:snapfi_mobile_challenge_pokedex_roveri/src/core/shared/data/rest_client/rest_client_exception.dart';

import 'mock_response.dart';

final class MockRestClientException<T extends Object> extends Mock
    implements RestClientException {
  void mockMessage(String message) =>
      when(() => this.message).thenReturn(message);

  void mockResponse(MockResponse<T> response) =>
      when(() => this.response).thenReturn(response);

  void mockStatusCode(int statusCode) =>
      when(() => this.statusCode).thenReturn(statusCode);
}
