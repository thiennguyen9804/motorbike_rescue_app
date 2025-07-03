import 'package:flutter/material.dart';
import 'package:motorbike_rescue_app/core/network/socket_client.dart';
import 'package:motorbike_rescue_app/data/dto/noti_created_dto.dart';

import '../../sl.dart';

abstract class ListenEmergencyService {
  void listenForEmergency(Function(NotiCreatedDto) handler);
}

class ListenEmergencyServiceImpl implements ListenEmergencyService {
  static const String _notiCreated = 'notification:created';
  static const String _notiUpdated = 'notification:updated';
  static const String _notiDeleted = 'notification:deleted';
  @override
  void listenForEmergency(Function(NotiCreatedDto) handler) {
    sl<SocketClient>().on(_notiCreated, (json) {
      debugPrint('noti dto: $json');
      final dto = NotiCreatedDto.fromJson(json);

      debugPrint(
          'ListenEmergencyServiceImp listenForEmergency noti created ${dto}');
      handler(dto);
    });

    sl<SocketClient>().on(_notiUpdated, (json) {
      final dto = NotiCreatedDto.fromJson(json);
      debugPrint(
          'ListenEmergencyServiceImp listenForEmergency noti updated ${dto}');
      handler(dto);
    });

    sl<SocketClient>().on(_notiDeleted, (json) {
      final dto = NotiCreatedDto.fromJson(json);
      debugPrint(
          'ListenEmergencyServiceImp listenForEmergency noti deleted${dto}');
      handler(dto);
    });
  }
}
