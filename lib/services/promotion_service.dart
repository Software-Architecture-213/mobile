import 'package:mobile/utils/dio/dio_brand.dart';
import '../models/promotion.dart';

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

}