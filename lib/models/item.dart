class Item {
  String? id; // Item ID
  String name; // Tên vật phẩm
  String? description; // Mô tả vật phẩm
  String? imageUrl; // Hình ảnh vật phẩm
  String rarity; // Hiếm có của vật phẩm
  bool tradable; // Có thể trao đổi hay không
  int maxQuantity; // Số lượng tối đa mà người dùng có thể sở hữu
  String? gameId; // Liên kết tới trò chơi
  DateTime createdAt; // Ngày tạo vật phẩm
  DateTime updatedAt; // Ngày cập nhật vật phẩm

  Item({
    this.id,
    required this.name,
    this.description,
    this.imageUrl,
    this.rarity = 'common',
    this.tradable = true,
    this.maxQuantity = 1,
    this.gameId,
    DateTime? createdAt,
    DateTime? updatedAt,
  })  : createdAt = createdAt ?? DateTime.now(),
        updatedAt = updatedAt ?? DateTime.now();

  factory Item.fromJson(Map<String, dynamic> json) {
    return Item(
      id: json['_id'],
      name: json['name'],
      description: json['description'],
      imageUrl: json['imageUrl'],
      rarity: json['rarity'] ?? 'common',
      tradable: json['tradable'] ?? true,
      maxQuantity: json['maxQuantity'] ?? 1,
      gameId: json['gameId'],
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'name': name,
      'description': description,
      'imageUrl': imageUrl,
      'rarity': rarity,
      'tradable': tradable,
      'maxQuantity': maxQuantity,
      'gameId': gameId,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }
}