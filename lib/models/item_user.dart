class ItemUser {
  String? id; // Item_User ID
  String? userId; // Người sở hữu
  String? itemId; // Vật phẩm
  String? gameId; // Trò chơi (để dễ tiến hành trao đổi trong 1 game)
  int quantity; // Số lượng
  DateTime createdAt; // Ngày sở hữu
  DateTime updatedAt; // Ngày cập nhật

  ItemUser({
    this.id,
    this.userId,
    this.itemId,
    this.gameId,
    this.quantity = 1,
    DateTime? createdAt,
    DateTime? updatedAt,
  })  : createdAt = createdAt ?? DateTime.now(),
        updatedAt = updatedAt ?? DateTime.now();

  factory ItemUser.fromJson(Map<String, dynamic> json) {
    return ItemUser(
      id: json['_id'],
      userId: json['userId'],
      itemId: json['itemId'],
      gameId: json['gameId'],
      quantity: json['quantity'] ?? 1,
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'userId': userId,
      'itemId': itemId,
      'gameId': gameId,
      'quantity': quantity,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }
}