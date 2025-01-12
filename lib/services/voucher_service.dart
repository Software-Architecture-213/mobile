import 'package:dio/dio.dart';
import 'package:mobile/utils/dio/dio_brand.dart';
import '../models/user_voucher.dart';
import '../models/voucher.dart';
import 'auth_service.dart';

class VoucherService{
  final dio = DioBrand().dio;
  Future<List<Voucher>> getAllVouchers() async {
    try {
      final response = await dio.get('/vouchers');
      if (response.statusCode == 200) {
        List<dynamic> data = response.data;
        return data.map((json) => Voucher.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load vouchers');
      }
    } catch (e) {
      throw Exception('Failed to load vouchers: $e');
    }
  }
  Future<List<UserVoucher>> getAllMyVouchers() async {
    try {
      final token = await AuthService().getToken();
      final response = await dio.get(
          '/vouchers/voucher/me',
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
          },
        ),
      );

      if (response.statusCode == 200) {
        List<dynamic> data = response.data;
        return data.map((json) => UserVoucher.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load all my vouchers');
      }
    } catch (e) {
      throw Exception('Failed to load all my vouchers: $e');
    }
  }
  Future<Voucher> getVoucherById(String id) async {
    try {
      final response = await dio.get('/vouchers/$id');
      if (response.statusCode == 200) {
        return Voucher.fromJson(response.data);
      } else {
        throw Exception('Failed to load voucher');
      }
    } catch (e) {
      throw Exception('Failed to load voucher: $e');
    }
  }
  Future<Voucher> getRandomVoucherByPromotionId(String promotionId) async {
    try {
      final response = await dio.get('/promotions/$promotionId/random/voucher');
      if (response.statusCode == 200) {
        return Voucher.fromJson(response.data);
      } else {
        throw Exception('Failed to load random voucher');
      }
    } catch (e) {
      throw Exception('Failed to load random voucher: $e');
    }
  }
  Future<UserVoucher> createUserVoucher(String voucherId) async {
    try {
      final token = await AuthService().getToken();
      final response = await dio.post(
        '/vouchers/voucher/me',
        data: {
          'voucherId': voucherId,
          'status': 'ACTIVE',
        },
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
          },
        ),
      );
      if (response.statusCode == 200) {
        return UserVoucher.fromJson(response.data);
      } else {
        throw Exception('Failed to create user voucher');
      }
    } catch (e) {
      throw Exception('Failed to create user voucher: $e');
    }
  }
}