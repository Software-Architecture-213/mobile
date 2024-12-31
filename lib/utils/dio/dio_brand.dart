import 'package:dio/dio.dart';

class DioBrand {
  static final DioBrand _instance = DioBrand._internal();
  late Dio dio;

  factory DioBrand() {
    return _instance;
  }

  DioBrand._internal() {
    dio = Dio(
      BaseOptions(
        baseUrl: 'http://10.0.2.2:80/api/brands',
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
    
  }
}
