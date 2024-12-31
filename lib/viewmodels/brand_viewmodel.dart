import 'package:flutter/material.dart';

import '../models/brand.dart';
import '../services/brand_services/brand_service.dart';

class BrandViewModel extends ChangeNotifier {
  final BrandService _brandService = BrandService();
  List<Brand> _brands = [];
  List<Brand> get brands => _brands;
  bool isLoading = false;

  Future<void> getAllBrands() async {
    isLoading = true;
    _brands = await _brandService.getAllBrands();
    isLoading = false;
    notifyListeners();
  }
}