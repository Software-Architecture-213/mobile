import 'package:flutter/material.dart';
import 'package:mobile/viewmodels/auth_viewmodel.dart';
import 'package:mobile/viewmodels/brand_viewmodel.dart';
import 'package:mobile/views/auth/Login/login_screen.dart';
import 'package:mobile/views/auth/register/register_screen.dart';
import 'package:mobile/views/branch/branch_screen.dart';
import 'package:mobile/views/home/home_screen.dart';
import 'package:mobile/views/profile/profile_screen.dart';
import 'package:mobile/views/promotion/promotion_screen.dart';
import 'package:mobile/views/voucher/voucher_screen.dart';
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
      title: 'Bin AI',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: VoucherDetailPage(),
    );
  }
}
