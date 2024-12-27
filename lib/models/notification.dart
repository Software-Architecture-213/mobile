class Notification {
  String? userId; // User ID
  String message; // Message
  String type; // Type of notification
  bool isRead; // Read status
  DateTime createdAt; // Creation date
  DateTime updatedAt; // Update date

  Notification({
    this.userId,
    required this.message,
    required this.type,
    this.isRead = false,
    DateTime? createdAt,
    DateTime? updatedAt,
  })  : createdAt = createdAt ?? DateTime.now(),
        updatedAt = updatedAt ?? DateTime.now();

  factory Notification.fromJson(Map<String, dynamic> json) {
    return Notification(
      userId: json['userId'],
      message: json['message'],
      type: json['type'],
      isRead: json['isRead'] ?? false,
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'message': message,
      'type': type,
      'isRead': isRead,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }
}