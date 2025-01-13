class NotificationModel {
  String message; // Message
  String? type; // Type of notification
  bool isRead; // Read status
  DateTime createdAt; // Creation date
  DateTime? updatedAt; // Update date

  NotificationModel({
    required this.message,
    this.type,
    this.isRead = false,
    required this.createdAt,
    this.updatedAt,
  }) ;

  factory NotificationModel.fromJson(Map<String, dynamic> json) {
    return NotificationModel(
      message: json['message'],
      type: json['type'] ?? '',
      isRead: json['isRead'] ?? false,
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: json['updateAt'] != null ? DateTime.parse(json['updateAt']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'message': message,
      'type': type,
      'isRead': isRead,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt?.toIso8601String(),
    };
  }
}