import 'package:dio/dio.dart';
import 'package:mobile/models/response/favourite_promotion_response.dart';
import 'package:mobile/utils/dio/dio_brand.dart';
import 'package:shared_preferences/shared_preferences.dart';
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
  //get favourite promotions by user id
  Future<FavouritePromotion> getFavouritePromotionsByUser() async {
    final prefs = await SharedPreferences.getInstance();
    final accessToken = prefs.getString('accessToken');

    if (accessToken == null) {
      throw Exception('Access token not found');
    }
    try {
      final response = await dio.get(
          '/promotions/favourite/me',
        options: Options(
          headers: {
            'Authorization': 'Bearer $accessToken',
          },
        ),
      );
      if (response.statusCode == 200) {
        return FavouritePromotion.fromJson(response.data);
      } else {
        throw Exception('Failed to load favourite promotions by user');
      }
    } catch (e) {
      throw Exception('Failed to load favourite promotions by user: $e');
    }
  }
}