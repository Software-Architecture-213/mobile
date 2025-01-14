import 'package:flutter/material.dart';
import 'package:mobile/models/response/convention_rule_response.dart';
import 'package:mobile/models/user_voucher.dart';
import 'package:mobile/models/voucher.dart';
import 'package:mobile/services/promotion_service.dart';
import 'package:mobile/services/voucher_service.dart';
import '../models/brand.dart';
import '../models/promotion.dart';
import '../models/response/favourite_promotion_response.dart';
import '../models/response/item_user_response.dart';
import '../services/brand_service.dart';
import '../services/convention_rule_service.dart';
import '../services/item_service.dart';

class BrandViewModel extends ChangeNotifier {
  final BrandService _brandService = BrandService();
  final PromotionService _promotionService = PromotionService();
  final VoucherService _voucherService = VoucherService();
  final ConventionRuleService _conventionRuleService = ConventionRuleService();
  final ItemService _itemService = ItemService();

  List<Brand> _brands = [];
  List<Brand> get brands => _brands;

  List<Promotion> _promotions = [];
  List<Promotion> get promotions => _promotions;

  FavouritePromotion? favouritePromotions;
  List<Voucher> _vouchers = [];
  List<Voucher> get vouchers => _vouchers;

  List<UserVoucher> _myVouchers = [];
  List<UserVoucher> get myVouchers => _myVouchers;

  ConversionRuleResponse? _conversionRule;
  ConversionRuleResponse? get conversionRule => _conversionRule;

  List<ItemUserResponse> _items = [];
  List<ItemUserResponse> get items => _items;

  Voucher? _randomVoucher;
  Voucher? get randomVoucher => _randomVoucher;

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
  Future<Voucher> getVoucherById(String id) async {
    return await _voucherService.getVoucherById(id);
  }
  Future<void> addFavourite(String promotionId) async {
    await _promotionService.addFavourite(promotionId);
    notifyListeners();
  }
  Future<void> getConversionRuleByPromotionId(String promotionId) async {
    _conversionRule = await _conventionRuleService.getConventionRuleByPromotionId(promotionId);
    notifyListeners();
  }
  Future<void> getRandomVoucherByPromotionId(String promotionId) async {
    _randomVoucher = await _voucherService.getRandomVoucherByPromotionId(promotionId);
    notifyListeners();
  }
  Future<void> createUserVoucher(String voucherId) async {
      await _voucherService.createUserVoucher(voucherId);
      notifyListeners();
  }
  Future<void> getItemUsersByUserIdAndPromotionId(String userId,String promotionId) async {
    _items = await _itemService.getItemUserByUserIdAndPromotionId(userId, promotionId);
    notifyListeners();
  }
  bool canExchangeVoucher() {
    if (_conversionRule == null) return false;

    for (var requiredItem in _conversionRule!.requiredItems) {
      bool itemExists = _items.any((item) => item.item?.id == requiredItem.id.itemId);
      if (!itemExists) {
        //print('Item not found: ${requiredItem.id.itemId}');
        return false;
      }
    }
    return true;
  }
  //delete item user
  Future<void> deleteItemUserByUserIdAndListItemId(String userId, List<String> items) async {
    await _itemService.deleteItemUserByUserIdAndListItemId(userId, items);
    notifyListeners();
  }

  //get favourite promotions by user id
  Future<void> getFavouritePromotionsByUser() async {
    favouritePromotions = await _promotionService.getFavouritePromotionsByUser();
    notifyListeners();
  }
}