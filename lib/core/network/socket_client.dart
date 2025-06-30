import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:motorbike_rescue_app/core/constant/network_constant.dart';
import 'package:motorbike_rescue_app/sl.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class SocketClient {
  late IO.Socket socket;
  late String authToken;

  void initSocket() {
    // Thay URL bằng địa chỉ server của bạn
    socket = IO.io(ServerNetworkConstant.BASE_SOCKET_URL, <String, dynamic>{
      'autoConnect': false,
      'auth': {'token': authToken}
    });

    // Kết nối
    socket.connect();

    // Lắng nghe sự kiện kết nối
    socket.onConnect((_) {
      debugPrint('Connected to socket server');
    });
  }

  void on(String event, Function(dynamic) handler) {
    socket.on(event, handler);
  }

  void disconnect() {
    socket.disconnect();
  }
}
