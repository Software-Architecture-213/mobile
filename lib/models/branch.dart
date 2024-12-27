class Brand {
  String? id; // Brand ID
  String displayName; // Tên thương hiệu
  String? imageUrl; // Hình ảnh thương hiệu
  String username; // Tên đăng nhập
  String password; // Mật khẩu
  String field; // Lĩnh vực hoạt động
  GPS gps; // Tọa độ GPS
  String status; // Trạng thái thương hiệu
  DateTime createdAt; // Ngày tạo
  DateTime updatedAt; // Ngày cập nhật

  Brand({
    this.id,
    required this.displayName,
    this.imageUrl,
    required this.username,
    required this.password,
    required this.field,
    required this.gps,
    this.status = 'active',
    DateTime? createdAt,
    DateTime? updatedAt,
  })  : createdAt = createdAt ?? DateTime.now(),
        updatedAt = updatedAt ?? DateTime.now();

  factory Brand.fromJson(Map<String, dynamic> json) {
    return Brand(
      id: json['_id'],
      displayName: json['displayName'],
      imageUrl: json['imageUrl'],
      username: json['username'],
      password: json['password'],
      field: json['field'],
      gps: GPS.fromJson(json['gps']),
      status: json['status'] ?? 'active',
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'displayName': displayName,
      'imageUrl': imageUrl,
      'username': username,
      'password': password,
      'field': field,
      'gps': gps.toJson(),
      'status': status,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }
}

class GPS {
  double latitude; // Latitude
  double longitude; // Longitude

  GPS({
    required this.latitude,
    required this.longitude,
  });

  factory GPS.fromJson(Map<String, dynamic> json) {
    return GPS(
      latitude: json['latitude'],
      longitude: json['longitude'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'latitude': latitude,
      'longitude': longitude,
    };
  }
}