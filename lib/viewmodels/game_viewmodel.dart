import 'package:flutter/material.dart';
import '../models/game.dart';
import '../models/response/api_response.dart';
import '../models/user.dart';
import '../services/game_service.dart';

class GameViewModel extends ChangeNotifier {
  final GameService _gameService = GameService();
  bool isLoadingGame = false;
  List<Game> _games = [];
  List<Game> get games => _games;
  Future<void> getAllGames() async {
    isLoadingGame = true;
    _games = await _gameService.getAllGames();
    isLoadingGame = false;
    notifyListeners();
  }
  //Get game by id
  Future<Game> getGameById(String id) async {
    return await _gameService.getGameById(id);
  }
}