import 'package:flutter/material.dart';

Widget menuOption(IconData icon, String text) {
  return Column(
    children: [
      CircleAvatar(
        radius: 24,
        backgroundColor: Colors.pink[50],
        child: Icon(icon, color: Colors.orange),
      ),
      SizedBox(height: 8),
      Text(
        text,
        style: TextStyle(fontSize: 12),
      ),
    ],
  );
}