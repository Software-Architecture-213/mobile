import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../viewmodels/auth_viewmodel.dart';

void showOtpDialog(BuildContext context, String email) {
  final TextEditingController otpController = TextEditingController();

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Nhập mã OTP'),
        content: TextField(
          controller: otpController,
          decoration: InputDecoration(hintText: "Mã OTP"),
          keyboardType: TextInputType.number,
        ),
        actions: <Widget>[
          TextButton(
            child: Text('Xác nhận'),
            onPressed: () async {
              final authViewModel = Provider.of<AuthViewModel>(context, listen: false);
              final response = await authViewModel.validateOtp(email, otpController.text);
              Navigator.of(context).pop();
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(response.message ?? 'OTP validation failed')),
              );
            },
          ),
          TextButton(
            child: Text('Hủy'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}
