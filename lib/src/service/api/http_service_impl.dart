import 'dart:io';

import 'package:dio/dio.dart';

import 'http_service_contract.dart';

class HttpService implements HttpServiceContract {
  late Dio _dio;
  late Dio _tokenDio;
  String baseUrl;
  String? refreshToken;
  DateTime? expirationDateTime;
  bool apiDebugMode = true;

  HttpService._(this.baseUrl, {this.apiDebugMode = true}) {
    final options = BaseOptions(
      baseUrl: baseUrl,
      connectTimeout: 120000,
      receiveTimeout: 300000,
      responseType: ResponseType.json,
      headers: {"Accept": "application/json"},
    );
    _dio = Dio(options);
    _tokenDio = Dio(options);
    _tokenDio.options = _dio.options;

    if (apiDebugMode) {
      final logInterceptor = LogInterceptor(
        requestBody: true,
        responseBody: true,
        error: true,
        request: true,
        requestHeader: true,
        responseHeader: true,
      );
      _dio.interceptors.add(logInterceptor);
      _tokenDio.interceptors.add(logInterceptor);
    }
  }

  factory HttpService(String baseUrl, {bool apiDebugMode = true}) {
    return HttpService._(baseUrl, apiDebugMode: apiDebugMode);
  }

  @override
  Dio get dio => _dio;

  @override
  Dio get tokenDio => _tokenDio;

  @override
  setToken(String? authToken, [String? refreshToken, DateTime? expiresIn]) {
    if (authToken == null || authToken.isEmpty) {
      throw Exception('Auth Token cannot be empty');
    }
    _tokenDio.options.headers['Authorization'] = 'Bearer $authToken';

    if (refreshToken != null) {
      this.refreshToken = refreshToken;
    }

    if (expiresIn != null) {
      expirationDateTime = expiresIn;
    }

    return this;
  }

  @override
  Future<dynamic> post(
    String route, {
    body,
    bool useHeaders = true,
    List<int> successStatusCodes = const [200, 201, 202],
  }) async {
    Response response;

    try {
      final fullRoute = route;
      response = await _tokenDio.post(
        fullRoute,
        data: body,
      );
    } on SocketException {
      return 'No Internet connection';
    } on FormatException {
      return 'Format Exception';
    } on DioError catch (dioError) {
      return dioError.response!.data['message'];
    }

    if (successStatusCodes.contains(response.statusCode)) {
      return Response(
          requestOptions: response.requestOptions, data: response.data);
    }
    return response.data['message'];
  }
}
