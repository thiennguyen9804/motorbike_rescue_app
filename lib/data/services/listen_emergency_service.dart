import 'package:motorbike_rescue_app/core/network/socket_client.dart';
import 'package:motorbike_rescue_app/data/dto/noti_created_dto.dart';

import '../../sl.dart';

abstract class ListenEmergencyService {
  void listenForEmergency(Function(NotiCreatedDto) handler);
}

class ListenEmergencyServiceImpl implements ListenEmergencyService {
  static const String _notiCreated = 'notification:created';
  @override
  void listenForEmergency(Function(NotiCreatedDto) handler) {
    sl<SocketClient>().on(_notiCreated, (json) {
      final dto = NotiCreatedDto.fromJson(json);
      handler(dto);
    });
  }
}
