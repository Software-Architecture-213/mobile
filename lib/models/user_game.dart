class UserGame {
  String userId; // ID of the user
  String gameId; // ID of the game
  int? score; // Score of the user in the game
  int? remainingTurns; // Remaining turns for the user
  int? earnedTurns; // Earned turns for the user
  DateTime createdAt; // Creation date
  DateTime? updatedAt; // Last update date

  UserGame({
    required this.userId,
    required this.gameId,
    this.score ,
    this.remainingTurns,
    this.earnedTurns ,
    required this.createdAt,
    this.updatedAt,
  });

  factory UserGame.fromJson(Map<String, dynamic> json) {
    return UserGame(
      userId: json['userId'],
      gameId: json['gameId'],
      score: json['score'] ?? 0,
      remainingTurns: json['remainingTurns'] ?? 10,
      earnedTurns: json['earnedTurns'] ?? 0,
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: json['updatedAt'] != null ? DateTime.parse(json['updatedAt']) : null,
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
      'updatedAt': updatedAt?.toIso8601String(),
    };
  }
}