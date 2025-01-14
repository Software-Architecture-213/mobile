import 'item.dart';

class ItemUser {
  String id;
  String userId;
  Item? item;
  String? gameId;
  int? quantity;
  DateTime createdAt;
  DateTime? updatedAt;

  ItemUser({
    required this.id,
    required this.userId,
    this.item,
    this.gameId,
    this.quantity,
    required this.createdAt,
    this.updatedAt,
  }) ;

  factory ItemUser.fromJson(Map<String, dynamic> json) {
    return ItemUser(
      id: json['_id'],
      userId: json['userId'],
      item: json['itemId'] != null ? Item.fromJson(json['itemId']) : null,
      gameId: json['gameId'] ?? '',
      quantity: json['quantity'] ?? 1,
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: json['updateAt'] != null ? DateTime.parse(json['updateAt']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'userId': userId,
      'itemId': item,
      'gameId': gameId,
      'quantity': quantity,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt?.toIso8601String(),
    };
  }
}