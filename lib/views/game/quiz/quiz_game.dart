import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dart:async';

import '../../../models/promotion.dart';
import '../../../models/quiz_game.dart';
import '../../../viewmodels/brand_viewmodel.dart';
import '../../../viewmodels/game_viewmodel.dart';
import '../widgets/result_dialog.dart';

class QuizGameApp extends StatefulWidget {
  String gameId;
  QuizGameApp({required this.gameId});
  @override
  _QuizGameAppState createState() => _QuizGameAppState();
}
class _QuizGameAppState extends State<QuizGameApp> {
  int currentQuestionIndex = 0;
  int timer = 10;
  Timer? countdownTimer;
  String? selectedAnswer;
  bool showResult = false;
  int correctAnswersCount = 0;
  @override
  void initState() {
    super.initState();
    Provider.of<GameViewModel>(context, listen: false).getQuizByGameId(widget.gameId);
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
    Future.delayed(Duration(seconds: 2), () {
      if (currentQuestionIndex < Provider.of<GameViewModel>(context, listen: false).quizGames.length - 1) {
        setState(() {
          currentQuestionIndex++;
          timer = 10;
          selectedAnswer = null;
          showResult = false;
        });
        startTimer();
      } else {
        showResultDialog(context,widget.gameId, correctAnswersCount,Provider.of<GameViewModel>(context, listen: false).quizGames.length);
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
    List<QuizGame> questions = Provider.of<GameViewModel>(context).quizGames;
    if (questions.isEmpty) {
      return Center(child: CircularProgressIndicator());
    }
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
                _buildQuestionSection(questions),
                _buildAnswerOptions(questions),
              ],
            ),
            _buildTimerIndicator(),
          ],
        ),
      ),
    );
  }

  Widget _buildQuestionSection(List<QuizGame> questions) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Text(
            questions[currentQuestionIndex].question,
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

  Widget _buildAnswerOptions(List<QuizGame> questions) {
    List<Answer> answers = questions[currentQuestionIndex].answers;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: answers.map((answer) => _buildAnswerButton(answer)).toList(),
    );
  }

  Widget _buildAnswerButton(Answer answer) {
    Color buttonColor = Colors.white;
    IconData? icon;

    if (showResult) {
      if (answer.isCorrect) {
        buttonColor = Colors.green;
        icon = Icons.check;
        if (selectedAnswer == answer.text) {
          correctAnswersCount++; // Increment the correct answers count
        }
      } else if (answer.text == selectedAnswer) {
        buttonColor = Colors.red;
        icon = Icons.close;
      }else {
        buttonColor = Colors.white; // Thay đổi màu của button khi hết thời gian đếm ngược
      }
    } else if (answer.text == selectedAnswer) {
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
              selectedAnswer = answer.text;
            });
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                answer.text,
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