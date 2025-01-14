import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../models/response/api_response.dart';
import '../../../services/auth_service.dart';

class GameInterceptor extends Interceptor {
  final Dio dio;
  GameInterceptor({required this.dio});

  @override
  void onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    // Thêm accessToken vào mỗi request
    final prefs = await SharedPreferences.getInstance();
    final accessToken = prefs.getString('accessToken');
    if (accessToken != null) {
      options.headers['Authorization'] = 'Bearer $accessToken';
    }
    handler.next(options);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    handler.next(response);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    if (err.response?.statusCode == 401) {
      // Token hết hạn, thử refresh token
      final refreshResponse = await refreshToken();
      if (refreshResponse.success) {
        // Lấy token mới và thử lại request ban đầu
        final newAccessToken = refreshResponse.data['accessToken'];
        err.requestOptions.headers['Authorization'] = 'Bearer $newAccessToken';
        final opts = Options(
          method: err.requestOptions.method,
          headers: err.requestOptions.headers,
        );
        final cloneReq = await dio.request(
          err.requestOptions.path,
          options: opts,
          data: err.requestOptions.data,
          queryParameters: err.requestOptions.queryParameters,
        );
        return handler.resolve(cloneReq);
      } else {
        // Refresh token thất bại, logout
        await logout();
      }
    }
    handler.next(err);
  }
  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('accessToken');
    await prefs.remove('refreshToken');
  }
  // refresh token
  Future<ApiResponse> refreshToken() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final refreshToken = prefs.getString('refreshToken');

      if (refreshToken == null) {
        throw Exception('Refresh token not found');
      }
      final response = await dio.post(
        '/auth/refresh-token',
        data: {
          'refreshToken': refreshToken,
        },
      );

      if (response.statusCode == 200) {
        final accessToken = response.data['accessToken'];
        final refreshToken = response.data['refreshToken'];

        // Save tokens to SharedPreferences
        await prefs.setString('accessToken', accessToken);
        await prefs.setString('refreshToken', refreshToken);
        return ApiResponse(
          success: true,
          message: 'Token refreshed',
          data: {
            'accessToken': accessToken,
            'refreshToken': refreshToken,
          },
          statusCode: response.statusCode ?? 200,
        );
      } else {
        return ApiResponse(
          success: false,
          message: 'Token refresh failed: ${response.data}',
          statusCode: response.statusCode ?? 400,
        );
      }
    } on DioException catch (e) {
      if (e.response != null) {
        return ApiResponse(
          success: false,
          message: 'Token refresh failed: ${e.response!.data}',
          statusCode: e.response!.statusCode ?? 400,
        );
      }
      return ApiResponse(
        success: false,
        message: 'Connection error: $e',
        statusCode: 500,
      );
    }
  }
}
