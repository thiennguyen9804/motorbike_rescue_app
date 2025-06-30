import 'package:latlong2/latlong.dart';

class NotiCreatedDto {
  final String title;
  final String body;
  final String userId;
  final EmergencyPayload payload;

  NotiCreatedDto({
    required this.title,
    required this.body,
    required this.userId,
    required this.payload,
  });

  factory NotiCreatedDto.fromJson(Map<String, dynamic> json) {
    return NotiCreatedDto(
      title: json['title'],
      body: json['body'],
      userId: json['userId'],
      payload: EmergencyPayload.fromJson(json['data']['payload']),
    );
  }
}

class EmergencyPayload {
  final String id;
  final String name;
  final LatLng position;
  final String status;
  final String lastUpdate;
  final String userId;

  EmergencyPayload({
    required this.id,
    required this.name,
    required this.position,
    required this.status,
    required this.lastUpdate,
    required this.userId,
  });

  factory EmergencyPayload.fromJson(Map<String, dynamic> json) {
    return EmergencyPayload(
      id: json['id'],
      name: json['name'],
      position: LatLng(
        json['position'][1],
        json['position'][0],
      ),
      status: json['status'],
      lastUpdate: json['lastUpdate'],
      userId: json['userId'],
    );
  }
}
