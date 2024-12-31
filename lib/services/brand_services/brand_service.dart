import 'package:mobile/utils/dio/dio_brand.dart';

import '../../models/brand.dart';

class BrandService{
  final dio = DioBrand().dio;
  Future<List<Brand>> getAllBrands() async {
    try {
      final response = await dio.get('/collection');
      if (response.statusCode == 200) {
        List<dynamic> data = response.data;
        return data.map((json) => Brand.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load brands');
      }
    } catch (e) {
      throw Exception('Failed to load brands: $e');
    }
  }
}