import 'package:flutter/material.dart';
import 'package:mobile/models/response/user_response.dart';
import 'package:mobile/views/my_item/my_item_screen.dart';
import 'package:mobile/views/my_voucher/my_voucher_screen.dart';
import 'package:provider/provider.dart';
import '../../viewmodels/auth_viewmodel.dart';
import '../auth/Login/login_screen.dart';
import '../favourite_promotion/favourite_screen.dart';
import '../transaction_history/transaction_screen.dart';

class ProfileScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  UserResponse? user ;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Provider.of<AuthViewModel>(context, listen: false).getProfile().then((value) {
      setState(() {
        user = value;
      });
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon:Icon(Icons.arrow_back_outlined), color: Colors.black),
        actions: [
          Padding(
              padding: const EdgeInsets.all(8.0),
              child: IconButton(
                  onPressed: () {
                  },
                  icon: Icon(Icons.more_horiz),
                  color: Colors.black)),
        ],
      ),
      body:
      user == null
          ? Center(child: CircularProgressIndicator())
          :
      SingleChildScrollView(
        child: Column(
          children: [
            CircleAvatar(
              radius: 40,
              backgroundImage: user?.photoUrl != null
            ? NetworkImage(user!.photoUrl!)
            : NetworkImage(
                  'https://cdn-icons-png.flaticon.com/512/3135/3135715.png'),
            ),
            SizedBox(height: 10),
            Text(
              user!.displayName,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 5),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.phone, size: 18, color: Colors.grey),
                SizedBox(width: 5),
                Text(user!.phoneNumber, style: TextStyle(color: Colors.grey)),
              ],
            ),
            SizedBox(height: 5),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.email, size: 18, color: Colors.grey),
                SizedBox(width: 5),
                Text(user!.email, style: TextStyle(color: Colors.grey)),
              ],
            ),
            SizedBox(height: 5),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.person, size: 18, color: Colors.grey),
                SizedBox(width: 5),
                Text(user!.userId, style: TextStyle(color: Colors.grey)),
              ],
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  children: [
                    Text(
                      '₹140.50',
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight
                          .bold),
                    ),
                    Text('Wallet', style: TextStyle(color: Colors.grey)),
                  ],
                ),
                Container(
                  height: 40,
                  width: 1,
                  color: Colors.grey[300],
                ),
                Column(
                  children: [
                    Text(
                      '12',
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight
                          .bold),
                    ),
                    Text('Orders', style: TextStyle(color: Colors.grey)),
                  ],
                ),
              ],
            ),
            SizedBox(height: 20),
            Divider(thickness: 1, color: Colors.grey[300]),
            ListTile(
              leading: Icon(Icons.card_giftcard, color: Colors.orange),
              title: Text('My Vouchers'),
              trailing: Icon(Icons.arrow_forward_ios, size: 16),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => MyVoucherScreen()),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.favorite, color: Colors.orange),
              title: Text('Favorite Promotions'),
              trailing: Icon(Icons.arrow_forward_ios, size: 16),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => FavouriteScreen()),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.extension, color: Colors.orange),
              title: Text('My items'),
              trailing: Icon(Icons.arrow_forward_ios, size: 16),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => MyItemScreen()),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.history, color: Colors.orange),
              title: Text('Transaction History'),
              trailing: Icon(Icons.arrow_forward_ios, size: 16),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => TransactionHistory()),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.share, color: Colors.orange),
              title: Text('Tell your friends'),
              trailing: Icon(Icons.arrow_forward_ios, size: 16),
            ),
            ListTile(
              leading: Icon(Icons.support, color: Colors.orange),
              title: Text('Support'),
              trailing: Icon(Icons.arrow_forward_ios, size: 16),
            ),
            ListTile(
              leading: Icon(Icons.settings, color: Colors.orange),
              title: Text('Settings'),
              trailing: Icon(Icons.arrow_forward_ios, size: 16),
            ),
            ListTile(
              leading: Icon(Icons.extension, color: Colors.orange),
              title: Text('Puzzle Collection'),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(
                        horizontal: 8, vertical: 2),
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      'New',
                      style: TextStyle(color: Colors.white, fontSize: 12),
                    ),
                  ),
                  SizedBox(width: 10),
                  Icon(Icons.arrow_forward_ios, size: 16),
                ],
              ),
            ),
            ListTile(
              leading: Icon(Icons.logout, color: Colors.orange),
              title: Text('Log out'),
              trailing: Icon(Icons.arrow_forward_ios, size: 16),
              onTap: () => _logout(context),
            ),
          ],
        ),
      ),
    );
  }
  void _logout(BuildContext context) async {
    await Provider.of<AuthViewModel>(context, listen: false).logout();
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => LoginScreen()),
          (Route<dynamic> route) => false,
    );
  }
}
