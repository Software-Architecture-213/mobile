import 'package:flutter/material.dart';
import 'dart:async';

import '../widgets/result_dialog.dart';

class QuizGame extends StatefulWidget {
  @override
  _QuizGameState createState() => _QuizGameState();
}

class _QuizGameState extends State<QuizGame> {
  List<Map<String, Object>> questions = [
    {
      'question': 'Four of the five major sports in the US have what word in their name?',
      'answers': ['Sports', 'League', 'Team'],
      'correctAnswer': 'League',
    },
    {
      'question': 'What is the capital of France?',
      'answers': ['Paris', 'London', 'Berlin'],
      'correctAnswer': 'Paris',
    },
    // Add more questions here
  ];

  int currentQuestionIndex = 0;
  int timer = 10;
  Timer? countdownTimer;
  String? selectedAnswer;
  bool showResult = false;

  @override
  void initState() {
    super.initState();
    startTimer();
  }

  void startTimer() {
    countdownTimer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        if (this.timer > 0) {
          this.timer--;
        } else {
          showResultAndNextQuestion();
        }
      });
    });
  }

  void showResultAndNextQuestion() {
    countdownTimer?.cancel();
    setState(() {
      showResult = true;
    });
    Future.delayed(Duration(seconds: 3), () {
      if (currentQuestionIndex < questions.length - 1) {
        setState(() {
          currentQuestionIndex++;
          timer = 10;
          selectedAnswer = null;
          showResult = false;
        });
        startTimer();
      } else {
        showResultDialog(context);
      }
    });
  }

  @override
  void dispose() {
    countdownTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.orangeAccent,
        body: Stack(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 100),
                _buildQuestionSection(),
                _buildAnswerOptions(),
              ],
            ),
            _buildTimerIndicator(),
          ],
        ),
      ),
    );
  }

  Widget _buildQuestionSection() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Text(
            questions[currentQuestionIndex]['question'] as String,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAnswerOptions() {
    List<String> answers = (questions[currentQuestionIndex]['answers'] as List<Object>).cast<String>();
    String correctAnswer = questions[currentQuestionIndex]['correctAnswer'] as String? ?? '';
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: answers.map((answer) => _buildAnswerButton(answer, correctAnswer)).toList(),
    );
  }

  Widget _buildAnswerButton(String answer, String correctAnswer) {
    Color buttonColor = Colors.white;
    IconData? icon;

    if (showResult) {
      if (answer == correctAnswer) {
        buttonColor = Colors.green;
        icon = Icons.check;
      } else if (answer == selectedAnswer) {
        buttonColor = Colors.red;
        icon = Icons.close;
      }else {
        buttonColor = Colors.white; // Thay đổi màu của button khi hết thời gian đếm ngược
      }
    } else if (answer == selectedAnswer) {
      buttonColor = Colors.blue;
    }

    return SizedBox(
      width: double.infinity,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 20.0),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: buttonColor,
            disabledBackgroundColor: buttonColor,
            padding: EdgeInsets.symmetric(vertical: 15),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
          ),
          onPressed: showResult ? null : () {
            setState(() {
              selectedAnswer = answer;
            });
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                answer,
                style: TextStyle(color: Colors.black, fontSize: 16),
              ),
              SizedBox(width: 5),
              if (icon != null) Icon(icon, color: Colors.white),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTimerIndicator() {
    return Positioned(
      top: 10,
      left: MediaQueryData.fromView(WidgetsBinding.instance.window).size.width / 2 - 40,
      child: Column(
        children: [
          CircleAvatar(
            radius: 40,
            backgroundColor: Colors.red,
            child: Text(
              timer.toString(),
              style: TextStyle(color: Colors.white, fontSize: 32),
            ),
          ),
          SizedBox(height: 5),
        ],
      ),
    );
  }
}