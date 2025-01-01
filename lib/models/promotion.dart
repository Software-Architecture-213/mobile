import 'package:mobile/models/voucher.dart';

class Promotion {
  String? id; // Promotion ID
  String name; // Tên khuyến mãi
  String? description; // Mô tả khuyến mãi
  String? imageUrl; // Hình ảnh khuyến mãi
  DateTime startDate; // Thời gian bắt đầu
  DateTime endDate; // Thời gian kết thúc
  String brandId; // Liên kết với thương hiệu
  double? budget; // Ngân sách dành cho khuyến mãi
  double? remainingBudget; // Ngân sách còn lại
  String status; // Trạng thái khuyến mãi
  List<Voucher>? vouchers; // Danh sách voucher trong khuyến mãi
  List<String>? games; // Danh sách trò chơi tham gia khuyến mãi
  DateTime createdAt; // Ngày tạo khuyến mãi
  DateTime? updatedAt; // Ngày cập nhật khuyến mãi

  Promotion({
    this.id,
    required this.name,
    this.description,
    this.imageUrl,
    required this.startDate,
    required this.endDate,
    required this.brandId,
    this.budget ,
    this.remainingBudget,
    required this.status ,
    this.vouchers,
    this.games,
    required this.createdAt,
    this.updatedAt,
  })  ;

  factory Promotion.fromJson(Map<String, dynamic> json) {
    return Promotion(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      description: json['description'] ?? '',
      imageUrl: json['imageUrl'] ,
      startDate: DateTime.parse(json['startDate']),
      endDate: DateTime.parse(json['endDate']),
      brandId: json['brandId'] ?? '',
      budget: json['budget']?.toDouble() ?? 0,
      remainingBudget: json['remainingBudget']?.toDouble() ?? 0,
      status: json['status'] ?? 'active',
      vouchers: json['vouchers'] != null
          ? List<Voucher>.from(json['vouchers'].map((v) => Voucher.fromJson(v)))
          : null,
      games: json['games'] != null ? List<String>.from(json['games']) : null,
      createdAt: DateTime.parse(json['createAt']),
      updatedAt: json['updateAt'] != null ? DateTime.parse(json['updateAt']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'imageUrl': imageUrl,
      'startDate': startDate.toIso8601String(),
      'endDate': endDate.toIso8601String(),
      'brandId': brandId,
      'budget': budget,
      'remainingBudget': remainingBudget,
      'status': status,
      'vouchers': vouchers?.map((v) => v.toJson()).toList(),
      'games': games,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt?.toIso8601String(),
    };
  }
}