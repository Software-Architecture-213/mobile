import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../viewmodels/auth_viewmodel.dart';
import '../Login/login_screen.dart';

void showOtpDialog(BuildContext context, String email) {
  final TextEditingController otpController = TextEditingController();
  final authViewModel = Provider.of<AuthViewModel>(context, listen: false);
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
            child: authViewModel.isLoadingValidateOtp
                ? const CircularProgressIndicator(
              color: Colors.white,
            )
                :Text('Xác nhận'),
            onPressed: () async {
              final authViewModel = Provider.of<AuthViewModel>(context, listen: false);
              final response = await authViewModel.validateOtp(email, otpController.text);
              if(response.success) {
                Navigator.of(context).pop();
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(response.message ?? 'OTP validation successful')),
                );
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => LoginScreen()),
                );
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(response.message ?? 'OTP validation failed')),
                );
              }
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
