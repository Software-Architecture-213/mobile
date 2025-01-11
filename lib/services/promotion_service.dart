import 'package:dio/dio.dart';
import 'package:mobile/utils/dio/dio_brand.dart';
import '../models/promotion.dart';
import 'auth_service.dart';

class PromotionService{
  final dio = DioBrand().dio;
  Future<List<Promotion>> getAllPromotions() async {
    try {
      final response = await dio.get('/promotions');
      if (response.statusCode == 200) {
        List<dynamic> data = response.data;
        return data.map((json) => Promotion.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load promotions');
      }
    } catch (e) {
      throw Exception('Failed to load promotions: $e');
    }
  }
  Future<void> addFavourite(String promotionId) async {
    try {
      final token = await AuthService().getToken();
      final response = await dio.post(
        '/promotions/favourite/$promotionId',
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
          },
        ),
      );
      if (response.statusCode != 200) {
        throw Exception('Failed to add favourite');
      }
    } catch (e) {
      throw Exception('Failed to add favourite: $e');
    }
  }

}