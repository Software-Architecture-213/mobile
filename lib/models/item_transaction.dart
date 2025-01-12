import 'item.dart';

class ItemTransaction {
  String id; // Transaction ID
  String senderId; // Người gửi
  String receiverId; // Người nhận
  Item item; // Vật phẩm được gửi
  DateTime? expiredAt; // Ngày hết hạn
  String status; // Trạng thái giao dịch
  DateTime createdAt; // Ngày gửi
  DateTime? updatedAt; // Ngày cập nhật

  ItemTransaction({
    required this.id,
    required this.senderId,
    required this.receiverId,
    required this.item,
    this.expiredAt,
    this.status = 'pending',
    required this.createdAt,
    this.updatedAt,
  })  ;

  factory ItemTransaction.fromJson(Map<String, dynamic> json) {
    return ItemTransaction(
      id: json['_id'],
      senderId: json['senderId'],
      receiverId: json['receiverId'],
      item: Item.fromJson(json['item']),
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
      'item': item.toJson(),
      'expiredAt': expiredAt?.toIso8601String(),
      'status': status,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt?.toIso8601String(),
    };
  }
}