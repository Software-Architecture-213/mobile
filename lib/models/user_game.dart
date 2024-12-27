class UserGame {
  String? userId; // ID of the user
  String? gameId; // ID of the game
  int score; // Score of the user in the game
  int remainingTurns; // Remaining turns for the user
  int earnedTurns; // Earned turns for the user
  DateTime createdAt; // Creation date
  DateTime updatedAt; // Last update date

  UserGame({
    this.userId,
    this.gameId,
    this.score = 0,
    this.remainingTurns = 10,
    this.earnedTurns = 0,
    DateTime? createdAt,
    DateTime? updatedAt,
  })  : createdAt = createdAt ?? DateTime.now(),
        updatedAt = updatedAt ?? DateTime.now();

  factory UserGame.fromJson(Map<String, dynamic> json) {
    return UserGame(
      userId: json['userId'],
      gameId: json['gameId'],
      score: json['score'] ?? 0,
      remainingTurns: json['remainingTurns'] ?? 10,
      earnedTurns: json['earnedTurns'] ?? 0,
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'gameId': gameId,
      'score': score,
      'remainingTurns': remainingTurns,
      'earnedTurns': earnedTurns,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }
}