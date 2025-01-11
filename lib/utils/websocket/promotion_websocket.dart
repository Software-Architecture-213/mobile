import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:web_socket_channel/status.dart' as status;
import 'dart:async';

class PromotionWebSocket {
  final WebSocketChannel channel;
  final Function onOpen;
  final StreamController _controller = StreamController.broadcast();

  PromotionWebSocket(String url, {required this.onOpen})
      : channel = WebSocketChannel.connect(Uri.parse(url)) {
    channel.stream.listen(
          (message) {
        _controller.add(message);
      },
      onDone: () {
        if (channel.closeCode == status.normalClosure) {
          onOpen();
        }
      },
      onError: (error) {
        print('WebSocket error: $error');
      },
      cancelOnError: true,
    );
    onOpen(); // Call onOpen when the connection is established
  }

  void sendMessage(String message) {
    channel.sink.add(message);
  }

  Stream get messages => _controller.stream;

  void close() {
    _controller.close();
    channel.sink.close();
  }
}