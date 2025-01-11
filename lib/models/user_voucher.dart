import 'package:mobile/models/voucher.dart';

class UserVoucher {
  String? id; // UserVoucher ID
  String userId; // Người sở hữu
  String? email; // Email người sở hữu
  Voucher voucher; // Voucher
  String? qrCode; // QR Code
  String status; // Trạng thái voucher
  DateTime? redeemedAt; // Ngày sử dụng voucher
  DateTime createdAt; // Ngày sở hữu
  DateTime? updatedAt; // Ngày cập nhật

  UserVoucher({
    this.id,
    required this.userId,
    this.email,
    required this.voucher,
    this.qrCode,
    this.status = 'active',
    this.redeemedAt,
    required this.createdAt,
    this.updatedAt,
  });

  factory UserVoucher.fromJson(Map<String, dynamic> json) {
    return UserVoucher(
      id: json['id'],
      userId: json['userId'],
      email: json['email'] ?? '',
      voucher: Voucher.fromJson(json['voucher']),
      qrCode: json['qrCode']  ?? '',
      status: json['status'] ?? 'active',
      redeemedAt: json['redeemedAt'] != null ? DateTime.parse(json['redeemedAt']) : null,
      createdAt: DateTime.parse(json['createAt']),
      updatedAt: json['updateAt'] != null ? DateTime.parse(json['updateAt']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'email': email,
      'voucher': voucher,
      'qrCode': qrCode,
      'status': status,
      'redeemedAt': redeemedAt?.toIso8601String(),
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt?.toIso8601String(),
    };
  }
}