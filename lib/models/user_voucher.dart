class UserVoucher {
  String? id; // UserVoucher ID
  String? userId; // Người sở hữu
  String? email; // Email người sở hữu
  String? voucherId; // Voucher
  String? qrCode; // QR Code
  String status; // Trạng thái voucher
  DateTime? redeemedAt; // Ngày sử dụng voucher
  DateTime createdAt; // Ngày sở hữu
  DateTime updatedAt; // Ngày cập nhật

  UserVoucher({
    this.id,
    this.userId,
    this.email,
    this.voucherId,
    this.qrCode,
    this.status = 'active',
    this.redeemedAt,
    DateTime? createdAt,
    DateTime? updatedAt,
  })  : createdAt = createdAt ?? DateTime.now(),
        updatedAt = updatedAt ?? DateTime.now();

  factory UserVoucher.fromJson(Map<String, dynamic> json) {
    return UserVoucher(
      id: json['_id'],
      userId: json['userId'],
      email: json['email'],
      voucherId: json['voucherId'],
      qrCode: json['qrCode'],
      status: json['status'] ?? 'active',
      redeemedAt: json['redeemedAt'] != null ? DateTime.parse(json['redeemedAt']) : null,
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'userId': userId,
      'email': email,
      'voucherId': voucherId,
      'qrCode': qrCode,
      'status': status,
      'redeemedAt': redeemedAt?.toIso8601String(),
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }
}