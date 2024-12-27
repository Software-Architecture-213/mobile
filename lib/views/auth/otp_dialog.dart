import 'package:flutter/material.dart';

void showOtpDialog(BuildContext context) {
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
            onPressed: () {
              // Xử lý mã OTP ở đây
              Navigator.of(context).pop();
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
