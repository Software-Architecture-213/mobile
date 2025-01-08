import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
void showPuzzleBottomSheet(BuildContext context, int index) {
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
                // Handle "Share With My Friend" logic
                showEmailDialog(context);
              },
              child: Text('Share With My Friend',style: TextStyle(color: Colors.black),),
            ),
          ],
        ),
      );
    },
  );
}
void showEmailDialog(BuildContext context) {
  final TextEditingController emailController = TextEditingController();

  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: Text('Share with Friends'),
        content: TextField(
          controller: emailController,
          decoration: InputDecoration(hintText: 'Email'),
        ),
        actions: [
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text('Cancel',style: TextStyle(color: Colors.red),),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.orangeAccent,
            ),
            onPressed: () async {
              String email = emailController.text.trim();
              final Uri emailUri = Uri(
                scheme: 'mailto',
                path: email,
                query: 'subject=${Uri.encodeQueryComponent('Subject')}&body=${Uri.encodeQueryComponent('send you a gift')}', // Properly encode the subject and body
              );
              if (await canLaunchUrl(emailUri)) {
                await launchUrl(emailUri);
                Navigator.of(context).pop(); // Close the dialog
                Navigator.of(context).pop(); // Close the bottom sheet
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Email sent successfully')),
                );
              } else {
                Navigator.of(context).pop(); // Close the dialog
                Navigator.of(context).pop(); // Close the bottom sheet
                // Handle the error when the email cannot be sent
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Could not send email')),
                );
              }
            },
            child: Text('Send',style: TextStyle(color: Colors.black),),
          ),
        ],
      );
    },
  );
}
