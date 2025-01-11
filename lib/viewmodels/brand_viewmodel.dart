import 'package:flutter/material.dart';
import 'package:mobile/models/user_voucher.dart';
import 'package:mobile/models/voucher.dart';
import 'package:mobile/services/promotion_service.dart';
import 'package:mobile/services/voucher_service.dart';
import '../models/brand.dart';
import '../models/promotion.dart';
import '../services/brand_service.dart';

class BrandViewModel extends ChangeNotifier {
  final BrandService _brandService = BrandService();
  final PromotionService _promotionService = PromotionService();
  final VoucherService _voucherService = VoucherService();

  List<Brand> _brands = [];
  List<Brand> get brands => _brands;

  List<Promotion> _promotions = [];
  List<Promotion> get promotions => _promotions;

  List<Voucher> _vouchers = [];
  List<Voucher> get vouchers => _vouchers;

  List<UserVoucher> _myVouchers = [];
  List<UserVoucher> get myVouchers => _myVouchers;

  bool isLoadingBrand = false;
  bool isLoadingPromotion = false;
  bool isLoadingVoucher = false;
  bool isLoadingMyVoucher = false;

  Future<void> getAllBrands() async {
    isLoadingBrand = true;
    _brands = await _brandService.getAllBrands();
    isLoadingBrand = false;
    notifyListeners();
  }
  Future<void> getAllPromotions() async {
    isLoadingPromotion = true;
    _promotions = await _promotionService.getAllPromotions();
    isLoadingPromotion = false;
    notifyListeners();
  }
  Future<void> getAllVouchers() async {
    isLoadingVoucher = true;
    _vouchers = await _voucherService.getAllVouchers();
    isLoadingVoucher = false;
    notifyListeners();
  }
  Future<void> getAllMyVouchers() async {
    isLoadingMyVoucher = true;
    _myVouchers = await _voucherService.getAllMyVouchers();
    isLoadingMyVoucher = false;
    notifyListeners();
  }
  Future<void> addFavourite(String promotionId) async {
    await _promotionService.addFavourite(promotionId);
  }
}