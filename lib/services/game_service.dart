import 'package:dio/dio.dart';
import '../models/game.dart';
import '../models/quiz_game.dart';
import '../utils/dio/dio_game.dart';

class GameService{
  final dio = DioGame().dio;
  Future<List<Game>> getAllGames() async {
    try {
      final response = await dio.get('/games');
      if (response.statusCode == 200) {
        List<dynamic> data = response.data;
        return data.map((json) => Game.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load games');
      }
    } catch (e) {
      throw Exception('Failed to load games: $e');
    }
  }
  Future<List<Game>> getAllGamesByPromotionId(String promotionId) async {
    try {
      final response = await dio.get('/games/promotions/$promotionId');
      if (response.statusCode == 200) {
        List<dynamic> data = response.data;
        return data.map((json) => Game.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load games by promotion');
      }
    } catch (e) {
      throw Exception('Failed to load games by promotion: $e');
    }
  }
  Future<Game> getGameById(String id) async {
    try {
      final response = await dio.get('/games/$id');
      if (response.statusCode == 200) {
        return Game.fromJson(response.data);
      } else {
        throw Exception('Failed to load game by id');
      }
    } catch (e) {
      throw Exception('Failed to load game by id: $e');
    }
  }
  Future<List<QuizGame>> getQuizByGameId(String gameId) async {
    try {
      final response = await dio.get('/quizQuestions/games/$gameId');
      if (response.statusCode == 200) {
        List<dynamic> data = response.data['data'];
        return data.map((json) => QuizGame.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load quiz game by game id');
      }
    } catch (e) {
      throw Exception('Failed to load quiz game by game id: $e');
    }
  }

}