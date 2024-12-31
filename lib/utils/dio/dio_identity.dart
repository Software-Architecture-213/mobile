import 'package:dio/dio.dart';


class DioIdentity {
  static final DioIdentity _instance = DioIdentity._internal();
  late Dio dio;

  factory DioIdentity() {
    return _instance;
  }

  DioIdentity._internal() {
    dio = Dio(
      BaseOptions(
        baseUrl: 'http://10.0.2.2:80/api/identity',
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
