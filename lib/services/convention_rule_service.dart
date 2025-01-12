import '../models/response/convention_rule_response.dart';
import '../utils/dio/dio_brand.dart';

class ConventionRuleService{
  final dio = DioBrand().dio;
  Future<List<ConversionRuleResponse>> getAllConventionRule() async {
    try {
      final response = await dio.get('/promotions/promotion/conversions-rule');
      if (response.statusCode == 200) {
        List<dynamic> data = response.data;
        return data.map((json) => ConversionRuleResponse.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load convention rule');
      }
    } catch (e) {
      throw Exception('Failed to load convention rule: $e');
    }
  }

  Future<ConversionRuleResponse> getConventionRuleByPromotionId(String promotionId) async {
    try {
      final response = await dio.get(
        '/promotions/promotion/conversions-rule',
        queryParameters: {'promotionId': promotionId},
      );
      if (response.statusCode == 200) {
        return ConversionRuleResponse.fromJson(response.data);
      } else {
        throw Exception('Failed to get convention rule by promotion id');
      }
    } catch (e) {
      throw Exception('Failed to get convention rule by promotion id: $e');
    }
  }
}