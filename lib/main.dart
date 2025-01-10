import 'package:flutter/material.dart';
import 'package:mobile/viewmodels/auth_viewmodel.dart';
import 'package:mobile/viewmodels/brand_viewmodel.dart';
import 'package:mobile/views/game/quiz/quiz_game.dart';
import 'package:provider/provider.dart';


void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => AuthViewModel()),
        ChangeNotifierProvider(create: (context) => BrandViewModel()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'VOU App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: QuizGame(),
    );
  }
}
