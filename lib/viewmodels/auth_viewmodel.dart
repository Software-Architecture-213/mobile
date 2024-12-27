import 'package:flutter/material.dart';
import '../services/identity_services/auth_service.dart';
import '../models/response/api_response.dart';
import '../models/user.dart';

class AuthViewModel extends ChangeNotifier {
  final AuthService _authService = AuthService();

  Future<ApiResponse> register(User user) async {
    final response = await _authService.register(user);
    // Notify listeners if needed
    notifyListeners();
    return response;
  }
  Future<ApiResponse> login(String email, String password) async {
    final response = await _authService.login(email, password);
    // Notify listeners if needed
    notifyListeners();
    return response;
  }
  Future<ApiResponse> generateOtp(String email) async {
    final response = await _authService.generateOtp(email);
    // Notify listeners if needed
    notifyListeners();
    return response;
  }

  Future<ApiResponse> validateOtp(String email, String otpCode) async {
    final response = await _authService.validateOtp(email, otpCode);
    // Notify listeners if needed
    notifyListeners();
    return response;
  }
}