// ignore_for_file: avoid_print

import 'package:web_socket_channel/web_socket_channel.dart';

class WebSocketService {
  WebSocketChannel? channel;

  void connectToWebSocket(String userId) {
    userId = '123'; // for test
    channel = WebSocketChannel.connect(
      Uri.parse('ws://10.0.2.2:80/api/brands/ws?userId=$userId'),
    );

    channel!.stream.listen((message) {
      // Handle incoming message (notification)
      print('Received notification: $message');
    }, onError: (error) {
      print('WebSocket error: $error');
    }, onDone: () {
      print('WebSocket connection closed');
    });
  }

  void sendNotification(String message) {
    if (channel != null) {
      channel!.sink.add(message);
    }
  }

  void closeConnection() {
    channel?.sink.close();
  }
}
