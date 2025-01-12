import 'package:flutter/material.dart';
import 'package:mobile/models/response/user_response.dart';
import '../services/auth_service.dart';
import '../models/response/api_response.dart';
import '../models/user.dart';

class AuthViewModel extends ChangeNotifier {
  final AuthService _authService = AuthService();

  UserResponse? user;
  bool isLoadingRegister = false;
  bool isLoadingLogin = false;
  bool isLoadingGenerateOtp = false;
  bool isLoadingValidateOtp = false;

  Future<ApiResponse> register(User user) async {
    isLoadingRegister = true;
    final response = await _authService.register(user);
    isLoadingRegister = false;
    notifyListeners();
    return response;
  }

  Future<ApiResponse> login(String email, String password) async {
    isLoadingLogin = true;
    final response = await _authService.login(email, password);
    isLoadingLogin = false;
    notifyListeners();
    return response;
  }

  Future<ApiResponse> generateOtp(String email) async {
    isLoadingGenerateOtp = true;
    final response = await _authService.generateOtp(email);
    isLoadingGenerateOtp = false;
    notifyListeners();
    return response;
  }

  Future<ApiResponse> validateOtp(String email, String otpCode) async {
    isLoadingValidateOtp = true;
    final response = await _authService.validateOtp(email, otpCode);
    isLoadingValidateOtp = false;
    notifyListeners();
    return response;
  }

  Future<UserResponse> getProfile() async {
    user =  await _authService.getProfile();
    return user!;
  }
  //logout
  Future<void> logout() async {
    await _authService.logout();
    user = null;
    notifyListeners();
  }

}