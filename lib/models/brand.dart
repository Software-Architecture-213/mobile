class Brand {
  String? id; // Brand ID
  String displayName; // Tên thương hiệu
  String? imageUrl; // Hình ảnh thương hiệu
  String username; // Tên đăng nhập
  String field; // Lĩnh vực hoạt động
  GPS gps; // Tọa độ GPS
  String status; // Trạng thái thương hiệu
  DateTime createdAt; // Ngày tạo
  DateTime? updatedAt; // Ngày cập nhật

  Brand({
    this.id,
    required this.displayName,
    this.imageUrl,
    required this.username,
    required this.field,
    required this.gps,
    required this.status,
    required this.createdAt,
    this.updatedAt,
  });

  factory Brand.fromJson(Map<String, dynamic> json) {
    return Brand(
      id: json['id'],
      displayName: json['displayName'] ?? '',
      imageUrl: json['imageUrl'],
      username: json['username'] ?? '',
      field: json['field'] ?? '',
      gps: GPS.fromJson(json['gps']),
      status: json['status'] ?? 'active',
      createdAt: DateTime.parse(json['createAt']),
      updatedAt: json['updateAt'] != null ? DateTime.parse(json['updateAt']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'displayName': displayName,
      'imageUrl': imageUrl,
      'username': username,
      'field': field,
      'gps': gps.toJson(),
      'status': status,
      'createAt': createdAt.toIso8601String(),
      'updateAt': updatedAt?.toIso8601String(),
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