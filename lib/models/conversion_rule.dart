class ConversionRule {
  String? id; // Rule ID
  List<RequiredItem> requiredItems; // List of required items with their quantities
  String? voucherId; // Voucher to be rewarded
  String? gameId; // Game ID
  DateTime createdAt; // Ngày tạo rule
  DateTime updatedAt; // Ngày cập nhật rule

  ConversionRule({
    this.id,
    required this.requiredItems,
    this.voucherId,
    this.gameId,
    DateTime? createdAt,
    DateTime? updatedAt,
  })  : createdAt = createdAt ?? DateTime.now(),
        updatedAt = updatedAt ?? DateTime.now();

  factory ConversionRule.fromJson(Map<String, dynamic> json) {
    return ConversionRule(
      id: json['_id'],
      requiredItems: (json['requiredItems'] as List)
          .map((item) => RequiredItem.fromJson(item))
          .toList(),
      voucherId: json['voucherId'],
      gameId: json['gameId'],
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'requiredItems': requiredItems.map((item) => item.toJson()).toList(),
      'voucherId': voucherId,
      'gameId': gameId,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }
}

class RequiredItem {
  String itemId; // Item ID
  int quantity; // Quantity

  RequiredItem({
    required this.itemId,
    required this.quantity,
  });

  factory RequiredItem.fromJson(Map<String, dynamic> json) {
    return RequiredItem(
      itemId: json['itemId'],
      quantity: json['quantity'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'itemId': itemId,
      'quantity': quantity,
    };
  }
}