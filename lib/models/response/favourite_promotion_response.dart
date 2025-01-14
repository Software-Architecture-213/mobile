import 'package:mobile/models/promotion.dart';

class FavouritePromotion {
  String id;
  String userId;
  List<Promotion> promotions;

  FavouritePromotion({
    required this.id,
    required this.userId,
    required this.promotions,
  });

  factory FavouritePromotion.fromJson(Map<String, dynamic> json) {
    return FavouritePromotion(
      id: json['id'],
      userId: json['userId'],
      promotions: (json['promotions'] as List)
          .map((promotionJson) => Promotion.fromJson(promotionJson))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'promotions': promotions.map((promotion) => promotion.toJson()).toList(),
    };
  }
}