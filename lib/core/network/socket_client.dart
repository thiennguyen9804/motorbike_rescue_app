import 'package:flutter/rendering.dart';
import 'package:latlong2/latlong.dart';
import 'package:motorbike_rescue_app/core/constant/network_constant.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:socket_io_client/socket_io_client.dart';

class SocketClient {
  late IO.Socket socket;
  late String authToken;

  static const HANDLE_JOINED_DEVICE_ROOM_CHANNEL = 'joined_device_room';
  static const HANDLE_LEAVED_DEVICE_ROOM_CHANNEL = 'leaved_device_room';

  void initSocket() {
    // Thay URL bằng địa chỉ server của bạn
    socket = IO.io(
      ServerNetworkConstant.BASE_SOCKET_URL,
      OptionBuilder()
          .setTransports(["websocket"])
          .disableAutoConnect()
          .setAuth(
            {'token': authToken},
          )
          .build(),
    );

    // Kết nối
    socket.connect();

    // Lắng nghe sự kiện kết nối
    socket.on('connect', (e) {
      debugPrint('✅ Connected: $e');
      _updateUserPosition();
    });

    socket.on('disconnect', (_) => print('❌ Disconnected'));
    socket.on('connect_error', (e) => print('🚫 Connect error: $e'));
    socket.on(
        'reconnect', (attempt) => print('🔄 Reconnected after $attempt tries'));
    socket.on('error', (e) => print('❗ Error: $e'));
    socket.on(HANDLE_JOINED_DEVICE_ROOM_CHANNEL, (data) {
      debugPrint('#########Joined room: $data');
    });
    socket.on(HANDLE_LEAVED_DEVICE_ROOM_CHANNEL, (data) {
      debugPrint('#########Leaved room: $data');
    });
  }

  void _updateUserPosition() {
    final coor = LatLng(10.870591, 106.748216);
    socket.emit('user/position',
        {'latitude': coor.latitude, 'longitude': coor.longitude});
  }

  void on(String event, Function(dynamic) handler) {
    socket.on(event, handler);
  }

  void disconnect() {
    socket.disconnect();
  }
}
