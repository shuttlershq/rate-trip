import 'package:dio/dio.dart';

abstract class HttpServiceContract {
  Dio get dio;

  Dio get tokenDio;

  setToken(String authToken, [String refreshToken, DateTime expiresIn]);

  Future<dynamic> post(
    String route, {
    body,
    List<int> successStatusCodes,
    bool useHeaders = true,
  });
}
