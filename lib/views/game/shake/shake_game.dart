import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';
import 'dart:math';
import 'dart:async';
import 'package:sensors_plus/sensors_plus.dart';
import 'package:vibration/vibration.dart';
import 'reward.dart';

class ShakeGame extends StatefulWidget {
  @override
  _ShakeGameState createState() => _ShakeGameState();
}

class _ShakeGameState extends State<ShakeGame> {
  Reward? currentReward;
  final double shakeThreshold = 15.0;
  final Random random = Random();
  Timer? debounceTimer;
  List<Reward> mockRewards = [
    Reward(name: 'Reward 1', imageUrl: 'assets/reward1.png'),
    Reward(name: 'Reward 2', imageUrl: 'assets/reward2.png'),
    Reward(name: 'Reward 3', imageUrl: 'assets/reward3.png'),
    // Thêm các phần thưởng khác
  ];
  late ConfettiController _confettiController;
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
  }
  @override
  void dispose() {
    _confettiController.dispose();
    super.dispose();
  }

  void _openGift() {
    _confettiController.play(); // Bắt đầu hiệu ứng rơi hoa giấy
  }

  void _selectRandomReward() {
    setState(() {
      currentReward = mockRewards[random.nextInt(mockRewards.length)];
    });
  }

  void _vibrate() async {
    if (await Vibration.hasVibrator() ?? false) {
      Vibration.vibrate(duration: 500); // Rung trong 500ms
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Center(child: Text('Shake Game',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 26),))),
      body: Stack(
        children: [
          currentReward == null
              ? Center(
                child: GestureDetector(
                  onTap: (){
                    _openGift(); // Bắt đầu hiệu ứng rơi hoa giấy
                    _selectRandomReward(); // Chọn phần thưởng khi nhấn nút
                    _vibrate(); // Rung khi nhấn nút
                  },
                  child: Image.asset('assets/gift.png', width: 300),
                ),
              )
              : Align(
                alignment: Alignment.center,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(currentReward!.imageUrl,
                      height: 200, // Set the desired height
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
