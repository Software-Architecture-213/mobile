class QuizGame {
  String id;
  String gameId;
  String question;
  List<Answer> answers;
  String difficulty;
  int points;

  QuizGame({
    required this.id,
    required this.gameId,
    required this.question,
    required this.answers,
    required this.difficulty,
    required this.points,
  });

  factory QuizGame.fromJson(Map<String, dynamic> json) {
    return QuizGame(
      id: json['_id'],
      gameId: json['gameId'],
      question: json['question'],
      answers: (json['answers'] as List).map((i) => Answer.fromJson(i)).toList(),
      difficulty: json['difficulty'],
      points: json['points'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'gameId': gameId,
      'question': question,
      'answers': answers.map((e) => e.toJson()).toList(),
      'difficulty': difficulty,
      'points': points,
    };
  }
}
class Answer {
  String text;
  bool isCorrect;

  Answer({required this.text, required this.isCorrect});

  factory Answer.fromJson(Map<String, dynamic> json) {
    return Answer(
      text: json['text'],
      isCorrect: json['isCorrect'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'text': text,
      'isCorrect': isCorrect,
    };
  }
}