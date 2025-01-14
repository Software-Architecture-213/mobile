import 'package:flutter/material.dart';

import '../models/notification.dart';

class NotificationViewmodel extends ChangeNotifier {
  bool isLoadingNotification = false;

  List<NotificationModel> _notifications = [];
  List<NotificationModel> get notifications => _notifications;

  //add notification
  Future<void> addNotification(NotificationModel notification) async {
    _notifications.add(notification);
    notifyListeners();
  }

}