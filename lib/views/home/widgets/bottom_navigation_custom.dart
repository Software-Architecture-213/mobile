import 'package:flutter/material.dart';
import 'package:mobile/viewmodels/notification_viewmodel.dart';
import 'package:provider/provider.dart';

class CustomBottomNavigation extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;

  const CustomBottomNavigation({
    Key? key,
    required this.currentIndex,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<NotificationViewmodel>(
      builder: (context, notificationViewModel, child) {
        return NavigationBar(
          onDestinationSelected: onTap,
          selectedIndex: currentIndex,
          destinations: <Widget>[
            NavigationDestination(
              selectedIcon: Icon(Icons.home),
              icon: Icon(Icons.home_outlined),
              label: 'Home',
            ),
            NavigationDestination(
              icon: Icon(Icons.wallet_giftcard),
              label: 'Vouchers',
            ),
            NavigationDestination(
              icon: Badge(label: Text('${notificationViewModel.notifications.length}'),child: Icon(Icons.notifications_sharp)),
              label: 'Notifications',
            ),
            NavigationDestination(
              icon: Icon(Icons.person),
              label: 'Profile',
            ),
          ],
        );
      },
    );
  }
}