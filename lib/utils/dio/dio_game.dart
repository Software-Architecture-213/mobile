import 'package:dio/dio.dart';

import 'interceptor/game_interceptor.dart';

class DioGame {
  static final DioGame _instance = DioGame._internal();
  late Dio dio;

  factory DioGame() {
    return _instance;
  }

  DioGame._internal() {
    dio = Dio(
      BaseOptions(
        baseUrl: 'http://10.0.2.2:80/api/games',
        connectTimeout: const Duration(seconds: 30),
        receiveTimeout: const Duration(seconds: 30),
      ),
    );

    // Thêm interceptor để log request/response
    dio.interceptors.add(LogInterceptor(
      request: true,
      requestHeader: true,
      requestBody: true,
      responseHeader: true,
      responseBody: true,
      error: true,
    ));
    dio.interceptors.add(GameInterceptor(dio: dio));
  }
}
