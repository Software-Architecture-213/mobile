import 'package:flutter/material.dart';
import 'package:mobile/viewmodels/auth_viewmodel.dart';
import 'package:mobile/viewmodels/brand_viewmodel.dart';
import 'package:mobile/views/auth/Login/login_screen.dart';
import 'package:mobile/views/auth/register/register_screen.dart';
import 'package:mobile/views/constant/bottom_sheet.dart';
import 'package:mobile/views/constant/share_bottomshet.dart';
import 'package:mobile/views/game/shake/shake_game.dart';
import 'package:mobile/views/gift/gift_screen.dart';
import 'package:mobile/views/home/home_screen.dart';
import 'package:mobile/views/profile/profile_screen.dart';
import 'package:mobile/views/promotion/promotion_screen.dart';
import 'package:mobile/views/voucher_detail/voucher_detail_screen.dart';
import 'package:mobile/views/voucher_detail/widgets/fragment_voucher.dart';
import 'package:provider/provider.dart';

import 'views/favourite_promotion/favourite_screen.dart';
import 'views/game/Quiz/quiz_game.dart';

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
      home: HomeScreen(),
    );
  }
}
