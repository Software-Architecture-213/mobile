import 'package:flutter/material.dart';
import 'package:mobile/views/constant/send_dialog.dart';
import '../../models/item_user.dart';
void showShareBottomSheet(BuildContext context, ItemUser item) {
  showModalBottomSheet(
    context: context,
    builder: (context) {
      return Container(
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(20),
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Số lượng: 1',
              style: TextStyle(
                color: Colors.black,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.orangeAccent,
                minimumSize: Size(double.infinity, 48),
              ),
              onPressed: () {
                // Handle "Share Everyone" logic
              },
              child: Text('Share Everyone',style: TextStyle(color: Colors.black),),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.orangeAccent,
                minimumSize: Size(double.infinity, 48),
              ),
              onPressed: () {
                showSendItemDialog(context, item);
              },
              child: Text('Share With My Friend',style: TextStyle(color: Colors.black),),
            ),
          ],
        ),
      );
    },
  );
}

