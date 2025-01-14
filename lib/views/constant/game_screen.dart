import 'package:flutter/material.dart';
import 'package:mobile/models/voucher.dart';
import 'package:provider/provider.dart';
import '../../viewmodels/game_viewmodel.dart';
import '../game/quiz/quiz_game.dart';
import '../game/shake/shake_game.dart';

class GameButtonsScreen extends StatefulWidget {
  final Voucher voucher;

  GameButtonsScreen({required this.voucher});

  @override
  _GameButtonsScreenState createState() => _GameButtonsScreenState();
}

class _GameButtonsScreenState extends State<GameButtonsScreen> {
  @override
  void initState() {
    super.initState();
    _fetchGames();
  }

  Future<void> _fetchGames() async {
    await Provider.of<GameViewModel>(context, listen: false).getAllGamesByPromotionId(widget.voucher.promotionId!);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Games',style: TextStyle(fontWeight: FontWeight.bold),),
      ),
      body: Consumer<GameViewModel>(
        builder: (context, gameViewModel, child) {
          if (gameViewModel.isLoadingGame) {
            return Center(child: CircularProgressIndicator());
          }

          if (gameViewModel.games.isEmpty) {
            return Center(child: Text('No games available'));
          }

          return ListView.builder(
            itemCount: gameViewModel.games.length,
            itemBuilder: (context, index) {
              final game = gameViewModel.games[index];
              return GestureDetector(
                onTap: () async{
                  if (game.type == 'shake') {
                    // Move to Shake Game
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ShakeGameApp(gameId: game.id,),
                      ),
                    );

                  } else if (game.type == 'quiz') {
                    // Call Quiz API
                    await Provider.of<GameViewModel>(context, listen: false).getQuizByGameId(game.id);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => QuizGameApp(gameId: game.id,),
                      ),
                    );
                  }
                },
                child: Card(
                  child: ListTile(
                    leading: Image.network(
                      game.imageUrl!,
                      height: 50,
                      width: 50,
                      fit: BoxFit.cover,
                    ),
                    title: Text(
                      game.name,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}