import 'item.dart';

class ItemUser {
  String id; // Item_User ID
  String userId; // Người sở hữu
  Item? item; // Vật phẩm
  String? gameId; // Trò chơi
  int? quantity; // Số lượng
  DateTime createdAt; // Ngày sở hữu
  DateTime? updatedAt; // Ngày cập nhật

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
      updatedAt: DateTime.parse(json['updatedAt']),
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