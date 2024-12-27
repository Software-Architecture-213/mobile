import 'package:mobile/models/voucher.dart';

class User {
  String? id; // ID định danh duy nhất
  String? username; // Tên đăng nhập
  String password; // Mật khẩu
  String email; // Email
  String role; // Vai trò người dùng
  String displayName; // Tên hiển thị
  String? avatarUrl; // Ảnh đại diện
  DateTime? dateOfBirth; // Ngày sinh
  String phoneNumber; // Số điện thoại (để xác thực OTP)
  String gender; // Giới tính
  String? facebookAccount; // Tài khoản Facebook (nếu có)
  String status; // Trạng thái người dùng
  int configs; // Lượt chơi của người dùng
  List<Voucher>? favoritePromotions; // Danh sách khuyến mãi yêu thích
  DateTime createdAt; // Ngày tạo
  DateTime updatedAt; // Ngày cập nhật

  User({
    this.id,
    this.username,
    required this.password,
    required this.email,
    required this.role,
    required this.displayName,
    this.avatarUrl,
    this.dateOfBirth,
    required this.phoneNumber,
    required this.gender,
    this.facebookAccount,
    this.status = 'active',
    this.configs = 10,
    this.favoritePromotions,
    DateTime? createdAt,
    DateTime? updatedAt,
  })  : createdAt = createdAt ?? DateTime.now(),
        updatedAt = updatedAt ?? DateTime.now();


  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['_id'],
      username: json['username'],
      password: json['password'],
      email: json['email'],
      role: json['role'],
      displayName: json['displayName'],
      avatarUrl: json['avatarUrl'],
      dateOfBirth: json['dateOfBirth'] != null ? DateTime.parse(json['dateOfBirth']) : null,
      phoneNumber: json['phoneNumber'],
      gender: json['gender'],
      facebookAccount: json['facebookAccount'],
      status: json['status'] ?? 'active',
      configs: json['configs'] ?? 10,
      favoritePromotions: json['favoritePromotions'] != null ? List<Voucher>.from(json['favoritePromotions']) : null,
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'username': username,
      'password': password,
      'email': email,
      'role': role,
      'displayName': displayName,
      'avatarUrl': avatarUrl,
      'dateOfBirth': dateOfBirth?.toIso8601String(),
      'phoneNumber': phoneNumber,
      'gender': gender,
      'facebookAccount': facebookAccount,
      'status': status,
      'configs': configs,
      'favoritePromotions': favoritePromotions,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }
}