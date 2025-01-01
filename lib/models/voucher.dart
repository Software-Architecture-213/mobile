class Voucher {
  String? id; // Voucher ID
  String code; // Tên mã voucher chung của sự kiện (VD: KATINAT20)
  String type; // Loại voucher
  String? imageUrl; // Hình ảnh voucher
  String valueType; // Loại giá trị của voucher
  double value; // Giá trị của voucher
  String? description; // Mô tả voucher
  DateTime expiredAt; // Ngày hết hạn
  String status; // Trạng thái voucher
  String? promotionId; // Liên kết tới Promotion
  int maxCounts; // Số voucher tối đa từ sự kiện
  int createdCounts; // Số voucher đã phát hành
  DateTime createdAt; // Ngày tạo voucher
  DateTime ?updatedAt; // Ngày cập nhật voucher

  Voucher({
    this.id,
    required this.code,
    required this.type,
    this.imageUrl,
    required this.valueType,
    required this.value,
    this.description,
    required this.expiredAt,
    required this.status,
    this.promotionId,
    this.maxCounts = 1,
    this.createdCounts = 0,
    required this.createdAt,
    this.updatedAt,
  });

  factory Voucher.fromJson(Map<String, dynamic> json) {
    return Voucher(
      id: json['id'] ?? '',
      code: json['code'] ?? '',
      type: json['type'] ?? '',
      imageUrl: json['imageUrl'] ?? '',
      valueType: json['valueType'] ?? '',
      value: json['value'].toDouble() ?? 0,
      description: json['description'] ?? '',
      expiredAt: DateTime.parse(json['expiredAt']) ,
      status: json['status'] ?? 'active',
      promotionId: json['promotionId'] ?? '',
      maxCounts: json['maxCounts'] ?? 1,
      createdCounts: json['createdCounts'] ?? 0,
      createdAt: DateTime.parse(json['createAt']),
      updatedAt: json['updateAt'] != null ? DateTime.parse(json['updateAt']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'code': code,
      'type': type,
      'imageUrl': imageUrl,
      'valueType': valueType,
      'value': value,
      'description': description,
      'expiredAt': expiredAt.toIso8601String(),
      'status': status,
      'promotionId': promotionId,
      'maxCounts': maxCounts,
      'createdCounts': createdCounts,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt?.toIso8601String(),
    };
  }
}