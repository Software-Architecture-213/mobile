import 'package:mobile/utils/dio/dio_brand.dart';
import '../models/promotion.dart';
import '../models/voucher.dart';

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

}