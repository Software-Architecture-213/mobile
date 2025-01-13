
import '../item.dart';

class ItemUserResponse {
  String id;
  String userId;
  Item? item;
  String? gameId;
  int? quantity;
  DateTime createdAt;
  DateTime? updatedAt;

  ItemUserResponse({
    required this.id,
    required this.userId,
    this.item,
    this.gameId,
    this.quantity,
    required this.createdAt,
    this.updatedAt,
  }) ;

  factory ItemUserResponse.fromJson(Map<String, dynamic> json) {
    return ItemUserResponse(
      id: json['_id'],
      userId: json['userId'],
      item: json['item'] != null ? Item.fromJson(json['item']) : null,
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
      'item': item,
      'gameId': gameId,
      'quantity': quantity,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt?.toIso8601String(),
    };
  }
}