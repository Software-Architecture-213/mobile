class ItemTransaction {
  String? id; // Transaction ID
  String? senderId; // Người gửi
  String? receiverId; // Người nhận
  String? itemId; // Vật phẩm được gửi
  DateTime? expiredAt; // Ngày hết hạn
  String status; // Trạng thái giao dịch
  DateTime createdAt; // Ngày gửi
  DateTime updatedAt; // Ngày cập nhật

  ItemTransaction({
    this.id,
    this.senderId,
    this.receiverId,
    this.itemId,
    this.expiredAt,
    this.status = 'pending',
    DateTime? createdAt,
    DateTime? updatedAt,
  })  : createdAt = createdAt ?? DateTime.now(),
        updatedAt = updatedAt ?? DateTime.now();

  factory ItemTransaction.fromJson(Map<String, dynamic> json) {
    return ItemTransaction(
      id: json['_id'],
      senderId: json['senderId'],
      receiverId: json['receiverId'],
      itemId: json['itemId'],
      expiredAt: json['expiredAt'] != null ? DateTime.parse(json['expiredAt']) : null,
      status: json['status'] ?? 'pending',
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'senderId': senderId,
      'receiverId': receiverId,
      'itemId': itemId,
      'expiredAt': expiredAt?.toIso8601String(),
      'status': status,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }
}