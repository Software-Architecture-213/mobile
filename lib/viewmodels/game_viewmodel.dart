import 'package:flutter/material.dart';
import 'package:mobile/models/item_user.dart';
import '../models/game.dart';
import '../models/item.dart';
import '../models/quiz_game.dart';
import '../services/game_service.dart';
import '../services/item_service.dart';

class GameViewModel extends ChangeNotifier {
  final GameService _gameService = GameService();
  final ItemService _itemService = ItemService();

  bool isLoadingGame = false;
  bool isLoadingQuizGame = false;
  bool isLoadingItem = false;

  Item? _randomItem;
  Item? get randomItem => _randomItem;

  List<Game> _games = [];
  List<Game> get games => _games;

  List<QuizGame> _quizGames = [];
  List<QuizGame> get quizGames => _quizGames;

  List<ItemUser> _items = [];
  List<ItemUser> get items => _items;

  //Get all games
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
  //Get quiz game by game id
  Future<void> getQuizByGameId(String gameId) async {
    isLoadingQuizGame = true;
    _quizGames = await _gameService.getQuizByGameId(gameId);
    isLoadingQuizGame = false;
    notifyListeners();
  }
  //Get all items by user id
  Future<void> getItemsByUserId(String userId) async {
    isLoadingItem = true;
    _items = await _itemService.getAllMyItems(userId);
    isLoadingItem = false;
    notifyListeners();
  }
  //Get random item by game id
  Future<void> getRandomItemByGameId(String gameId) async {
    _randomItem = await _itemService.getRandomItemByGameId(gameId);
    notifyListeners();
  }
  //Create item user
  Future<void> createItemUser(String userId, String itemId, String gameId, int quantity) async {
    try {
      await _itemService.createItemUser(userId, itemId, gameId, quantity);
      notifyListeners();
    } catch (e) {
      // Handle error
    }
  }
}