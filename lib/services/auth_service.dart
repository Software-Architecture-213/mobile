import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/response/api_response.dart';
import '../models/response/user_response.dart';
import '../models/user.dart';
import '../utils/dio/dio_identity.dart';

class AuthService{
  final dio = DioIdentity().dio;
  Future<ApiResponse> register(User user) async {
    try {
      final response = await dio.post(
        '/auth/register',
        data: user.toJson(),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        return ApiResponse(
          success: true,
          message: 'Đăng ký thành công',
          data: response.data,
          statusCode: response.statusCode ?? 200,
        );
      } else {
        log('data: ${response.data}');
        return ApiResponse(
          success: false,
          message: 'Đăng ký thất bại: ${response.data}',
          statusCode: response.statusCode ?? 400,
        );
      }
    } on DioException catch (e) {
      if (e.response != null) {
        final errorData = e.response!.data;
        String errorMessage = 'Đăng ký thất bại';
        return ApiResponse(
          success: false,
          message: errorMessage,
          statusCode: e.response!.statusCode ?? 400,
        );
      }
      return ApiResponse(
        success: false,
        message: 'Lỗi kết nối: $e',
        statusCode: 500,
      );
    }
  }
  Future<ApiResponse> login(String email, String password) async {
    try {
      final response = await dio.post(
        '/auth/login',
        data: {
          'email': email,
          'password': password,
        },
      );

      if (response.statusCode == 200) {
        final accessToken = response.data['accessToken'];
        final refreshToken = response.data['refreshToken'];

        // Save tokens to SharedPreferences
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('accessToken', accessToken);
        await prefs.setString('refreshToken', refreshToken);
        return ApiResponse(
          success: true,
          message: 'Đăng nhập thành công',
          data: {
            'accessToken': response.data['accessToken'],
            'refreshToken': response.data['refreshToken'],
          },
          statusCode: response.statusCode ?? 200,
        );
      } else {
        return ApiResponse(
          success: false,
          message: 'Đăng nhập thất bại: ${response.data['message']}',
          statusCode: response.statusCode ?? 401,
        );
      }
    } on DioException catch (e) {
      if (e.response != null) {
        return ApiResponse(
          success: false,
          message: 'Đăng nhập thất bại: ${e.response!.data['message']}',
          statusCode: e.response!.statusCode ?? 401,
        );
      }
      return ApiResponse(
        success: false,
        message: 'Lỗi kết nối: $e',
        statusCode: 500,
      );
    }
  }
  Future<ApiResponse> generateOtp(String email) async {
    try {
      final response = await dio.post(
        '/auth/otp/generate',
        data: {
          'email': email,
        },
      );

      if (response.statusCode == 200) {
        return ApiResponse(
          success: true,
          message: 'OTP sent to $email',
          data: response.data,
          statusCode: response.statusCode ?? 200,
        );
      } else {
        return ApiResponse(
          success: false,
          message: 'OTP generation failed: ${response.data['message']}',
          statusCode: response.statusCode ?? 500,
        );
      }
    } on DioException catch (e) {
      if (e.response != null) {
        return ApiResponse(
          success: false,
          message: 'OTP generation failed: ${e.response!.data['message']}',
          statusCode: e.response!.statusCode ?? 500,
        );
      }
      return ApiResponse(
        success: false,
        message: 'Connection error: $e',
        statusCode: 500,
      );
    }
  }
  Future<ApiResponse> validateOtp(String email, String otpCode) async {
    try {
      final response = await dio.post(
        '/auth/otp/validate',
        data: {
          'email': email,
          'otpCode': otpCode,
        },
      );

      if (response.statusCode == 200) {
        return ApiResponse(
          success: true,
          message: 'OTP is valid!',
          data: response.data,
          statusCode: response.statusCode ?? 200,
        );
      } else {
        return ApiResponse(
          success: false,
          message: 'Invalid or expired OTP.',
          statusCode: response.statusCode ?? 400,
        );
      }
    } on DioException catch (e) {
      if (e.response != null) {
        return ApiResponse(
          success: false,
          message: 'Invalid or expired OTP.',
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
  //Get profile
  Future<UserResponse> getProfile() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final accessToken = prefs.getString('accessToken');

      if (accessToken == null) {
        throw Exception('Access token not found');
      }
      final response = await dio.get(
          '/users/me',
        options: Options(
          headers: {
            'Authorization': 'Bearer $accessToken',
          },
        ),
      );
      if (response.statusCode == 200) {
        return UserResponse.fromJson(response.data);
      } else {
        throw Exception('Lấy thông tin thất bại: ${response.data}');
      }
    } on DioException catch (e) {
      if (e.response != null) {
        throw Exception('Lấy thông tin thất bại: ${e.response!.data}');
      }
      throw Exception('Lỗi kết nối: $e');
    }
  }
  Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('accessToken');
  }
}