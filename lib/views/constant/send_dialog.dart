import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../models/item_user.dart';
import '../../models/response/user_response.dart';
import '../../utils/validators/email_validator.dart';
import '../../viewmodels/auth_viewmodel.dart';
import '../../viewmodels/game_viewmodel.dart';
import '../home/home_screen.dart';

void showSendItemDialog(BuildContext context, ItemUser item) {
  final TextEditingController emailController = TextEditingController();

  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: Text('Share with Friends'),
        content: TextFormField(
          controller: emailController,
          decoration: InputDecoration(hintText: 'Email receiver'),
          validator: EmailValidator.validate,
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
              try {
                await Provider.of<AuthViewModel>(context, listen: false).getUserInfoByEmail(emailController.text);
                UserResponse? userReceiver = Provider.of<AuthViewModel>(context, listen: false).userReceiver;
                UserResponse user = Provider.of<AuthViewModel>(context, listen: false).user!;
                if (userReceiver != null) {
                  await Provider.of<GameViewModel>(context, listen: false).checkAndUpdate(userReceiver.userId, item.item!.id, item.gameId!, 1);
                  await Provider.of<GameViewModel>(context, listen: false).checkAndUpdate(user.userId, item.item!.id, item.gameId!, -1);
                  await Provider.of<GameViewModel>(context, listen: false).createItemTransaction(user.userId, userReceiver.userId, item.item!.id, 1, "accepted");

                  // Show Snackbar
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Item sent successfully')),
                  );

                  // Navigate to HomeScreen
                  Navigator.of(context).pop(); // Close the dialog
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (context) => HomeScreen()),
                  );
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('User receiver not found')),
                  );
                }
              } catch (e) {
                if (e.toString().contains('500')) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Error 500: Internal Server Error')),
                  );
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('An error occurred: $e')),
                  );
                }
              }
            },
            child: Text('Send',style: TextStyle(color: Colors.black),),
          ),
        ],
      );
    },
  );
}