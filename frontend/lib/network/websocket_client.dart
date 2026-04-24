import 'dart:convert';
import 'package:web_socket_channel/web_socket_channel.dart';

class GameWebSocket {
  late WebSocketChannel _channel;
  final String url;
  final void Function(Map<String, dynamic>) onMessage;

  GameWebSocket({required this.url, required this.onMessage});

  void connect() {
    _channel = WebSocketChannel.connect(Uri.parse(url));
    _channel.stream.listen(
      (message) {
        final data = jsonDecode(message);
        onMessage(data);
      },
      onError: (error) => print('WS error: $error'),
      onDone: () => print('WS closed'),
    );
  }

  void send(Map<String, dynamic> data) {
    _channel.sink.add(jsonEncode(data));
  }

  void close() {
    _channel.sink.close();
  }
}