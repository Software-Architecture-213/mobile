import 'package:mobile/models/item.dart';
import 'package:mobile/models/item_transaction.dart';
import 'package:mobile/models/item_user.dart';
import '../utils/dio/dio_game.dart';

class ItemService{
  final dio = DioGame().dio;
  Future<List<Item>> getAllItems() async {
    try {
      final response = await dio.get('/items');
      if (response.statusCode == 200) {
        List<dynamic> data = response.data;
        return data.map((json) => Item.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load items');
      }
    } catch (e) {
      throw Exception('Failed to load items: $e');
    }
  }
  Future<List<ItemUser>> getAllMyItems(String userId) async {
    try {
      final response = await dio.get(
        '/itemUsers/user/$userId',
      );

      if (response.statusCode == 200) {
        List<dynamic> data = response.data['data'];
        return data.map((json) => ItemUser.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load all my items');
      }
    } catch (e) {
      throw Exception('Failed to load all my items: $e');
    }
  }
  Future<Item> getRandomItemByGameId(String gameId) async {
    try {
      final response = await dio.get('/items/game/$gameId/random');
      if (response.statusCode == 200) {
        return Item.fromJson(response.data['data']);
      } else {
        throw Exception('Failed to load item');
      }
    } catch (e) {
      throw Exception('Failed to load item: $e');
    }
  }
  Future<ItemUser> createItemUser(String userId, String itemId, String gameId, int quantity) async {
    try {
      final response = await dio.post(
        '/itemUsers/',
        data: {
          'userId': userId,
          'itemId': itemId,
          'gameId': gameId,
          'quantity': quantity,
        },
      );
      if (response.statusCode == 200) {
        return ItemUser.fromJson(response.data);
      } else {
        throw Exception('Failed to create item user');
      }
    } catch (e) {
      throw Exception('Failed to create item user: $e');
    }
  }
  Future<List<ItemTransaction>> getAllItemTransactionsByUserId(String userId) async {
    try {
      final response = await dio.get('/itemTransactions/user/$userId');
      if (response.statusCode == 200) {
        List<dynamic> data = response.data['data'];
        return data.map((json) => ItemTransaction.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load item transactions by user id');
      }
    } catch (e) {
      throw Exception('Failed to load transactions by user id: $e');
    }
  }

}