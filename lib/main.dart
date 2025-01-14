import 'package:flutter/material.dart';
import 'package:mobile/viewmodels/auth_viewmodel.dart';
import 'package:mobile/viewmodels/brand_viewmodel.dart';
import 'package:mobile/viewmodels/game_viewmodel.dart';
import 'package:mobile/viewmodels/notification_viewmodel.dart';
import 'package:mobile/views/auth/login/login_screen.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => AuthViewModel()),
        ChangeNotifierProvider(create: (context) => BrandViewModel()),
        ChangeNotifierProvider(create: (context) => GameViewModel()),
        ChangeNotifierProvider(create: (context) => NotificationViewmodel()),
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
      home: LoginScreen(),
    );
  }
}
