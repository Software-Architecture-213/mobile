class Game {
  String id; // Game ID
  String name; // Tên trò chơi
  String type; // Loại trò chơi
  String? imageUrl; // Hình ảnh đại diện trò chơi
  String? description; // Giới thiệu trò chơi
  String? guideline; // Hướng dẫn trò chơi
  bool? allowItemExchange; // Cho phép trao đổi vật phẩm hay không
  String? difficulty; // Mức độ khó của trò chơi
  String? promotionId; // Liên kết với Promotion
  DateTime createdAt; // Ngày tạo trò chơi
  DateTime? updatedAt; // Ngày cập nhật trò chơi

  Game({
    required this.id,
    required this.name,
    required this.type,
    this.imageUrl,
    this.description,
    this.guideline,
    this.allowItemExchange,
    this.difficulty,
    this.promotionId,
    required this.createdAt,
    this.updatedAt,
  })  ;

  factory Game.fromJson(Map<String, dynamic> json) {
    return Game(
      id: json['_id'],
      name: json['name'],
      type: json['type'],
      imageUrl: json['imageUrl'] ?? '',
      description: json['description'] ?? '',
      guideline: json['guideline'] ?? '',
      allowItemExchange: json['allowItemExchange'] ?? false,
      difficulty: json['difficulty'] ?? 'medium',
      promotionId: json['promotionId'] ?? '',
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: json['updatedAt'] != null ? DateTime.parse(json['updatedAt']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'name': name,
      'type': type,
      'imageUrl': imageUrl,
      'description': description,
      'guideline': guideline,
      'allowItemExchange': allowItemExchange,
      'difficulty': difficulty,
      'promotionId': promotionId,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt?.toIso8601String(),
    };
  }
}