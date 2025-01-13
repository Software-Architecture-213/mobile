import 'package:mobile/models/voucher.dart';

class ConversionRuleResponse {
  String id;
  List<RequiredItem> requiredItems;
  Voucher voucher;
  //Promotion promotion;


  ConversionRuleResponse({
    required this.id,
    required this.requiredItems,
    required this.voucher,
    //required this.promotion,
  })  ;

  factory ConversionRuleResponse.fromJson(Map<String, dynamic> json) {
    return ConversionRuleResponse(
      id: json['id'],
      requiredItems: (json['items'] as List)
          .map((item) => RequiredItem.fromJson(item))
          .toList(),
      voucher: Voucher.fromJson(json['voucher']),
      //promotion: Promotion.fromJson(json['promotion']),
    );
  }
}

class RequiredItem {
  Id id;
  int quantity;

  RequiredItem({
    required this.id,
    required this.quantity,
  });

  factory RequiredItem.fromJson(Map<String, dynamic> json) {
    return RequiredItem(
      id: Id.fromJson(json['id']),
      quantity: json['quantity'] is int ? json['quantity'] : int.parse(json['quantity']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id.toJson(),
      'quantity': quantity,
    };
  }
}

class Id {
  String conversionRuleId; // Conversion Rule ID
  String itemId; // Item ID

  Id({
    required this.conversionRuleId,
    required this.itemId,
  });

  factory Id.fromJson(Map<String, dynamic> json) {
    return Id(
      conversionRuleId: json['conversionRuleId'],
      itemId: json['itemId'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'conversionRuleId': conversionRuleId,
      'itemId': itemId,
    };
  }
}