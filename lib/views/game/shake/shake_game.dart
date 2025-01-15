import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';
import 'package:mobile/models/response/user_response.dart';
import 'package:mobile/models/user_game.dart';
import 'package:mobile/viewmodels/auth_viewmodel.dart';
import 'package:provider/provider.dart';
import 'dart:math';
import 'dart:async';
import 'package:sensors_plus/sensors_plus.dart';
import 'package:vibration/vibration.dart';
import '../../../models/item.dart';
import '../../../viewmodels/game_viewmodel.dart';

class ShakeGameApp extends StatefulWidget {
  String gameId;
  ShakeGameApp({required this.gameId});
  @override
  _ShakeGameAppState createState() => _ShakeGameAppState();
}

class _ShakeGameAppState extends State<ShakeGameApp> {
  Item? currentReward;
  final double shakeThreshold = 15.0;
  final Random random = Random();
  Timer? debounceTimer;
  late ConfettiController _confettiController;
  UserResponse? user;
  UserGame? userGame;
  @override
  void initState() {
    super.initState();
    accelerometerEvents.listen((AccelerometerEvent event) {
      if (event.x.abs() > shakeThreshold || event.y.abs() > shakeThreshold || event.z.abs() > shakeThreshold) {
        if (debounceTimer == null || !debounceTimer!.isActive) {
          debounceTimer = Timer(Duration(seconds: 1), () {});
          _selectRandomReward();
        }
      }
    });
    _confettiController = ConfettiController(duration: const Duration(seconds: 2));
    _initUserGame();
  }
  void _initUserGame() async {
    user =  Provider.of<AuthViewModel>(context, listen: false).user!;
    Provider.of<GameViewModel>(context, listen: false).getUserGameByUserId(user!.userId, widget.gameId);
    userGame = Provider.of<GameViewModel>(context, listen: false).userGame;
    Provider.of<GameViewModel>(context, listen: false).getQuizByGameId(widget.gameId);
  }
  @override
  void dispose() {
    _confettiController.dispose();
    super.dispose();
  }

  void _openGift() {
    _confettiController.play(); // Bắt đầu hiệu ứng rơi hoa giấy
  }

  void _selectRandomReward() async{
    await Provider.of<GameViewModel>(context, listen: false).getRandomItemByGameId(widget.gameId);
    setState(() {
      currentReward = Provider.of<GameViewModel>(context, listen: false).randomItem;
    });
    await Provider.of<GameViewModel>(context, listen: false).createItemUser(user!.userId, currentReward!.id, widget.gameId, 1);
  }

  void _vibrate() async {
    if (await Vibration.hasVibrator() ?? false) {
      Vibration.vibrate(duration: 500); // Rung trong 500ms
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon:Icon(Icons.arrow_back_outlined), color: Colors.black),
          title: Text(
            'Shake Game',
            style: TextStyle(fontWeight: FontWeight.bold,fontSize: 26),
            ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              padding: EdgeInsets.all(5),
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 241, 223, 199),
                borderRadius: BorderRadius.circular(12.0),
              ),
              child: Row(
                children: [
                  const Icon(
                    Icons.flash_on,
                    color: Colors.orange,
                  ),
                  Text(
                    userGame?.remainingTurns != null ? userGame!.remainingTurns.toString() : "10",
                    style:  TextStyle(
                      fontSize: 16,
                      color: Colors.orange,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    width: 5,
                  )
                ],
              ),
            ),
          ),
        ],
      ),
      body: Stack(
        children: [
          currentReward == null
              ? Center(
                child: GestureDetector(
                  onTap: (){
                    _openGift(); // Bắt đầu hiệu ứng rơi hoa giấy
                    _vibrate(); // Rung khi nhấn nút
                    _selectRandomReward(); // Chọn phần thưởng khi nhấn nút
                  },
                  child: Image.asset('assets/gift.png', width: 300),
                ),
              )
              : Align(
                alignment: Alignment.center,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.network(currentReward!.imageUrl!,
                      height: 200,
                      width: 300,
                      fit: BoxFit.fitWidth,),
                    SizedBox(height: 10),
                    Text(currentReward!.name, style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600)),
                  ],
                ),
              ),
            Align(
              alignment: Alignment.topCenter,
              child: ConfettiWidget(
                confettiController: _confettiController,
                blastDirection: -3.14 / 2, // Rơi thẳng từ trên xuống
                emissionFrequency: 0.05,
                numberOfParticles: 30,
                gravity: 0.5,
                colors: [Colors.red, Colors.blue, Colors.green, Colors.orange],
              ),
            ),
        ],
      ),
    );
  }
}
