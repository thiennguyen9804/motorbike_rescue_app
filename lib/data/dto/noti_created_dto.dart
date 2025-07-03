import 'package:latlong2/latlong.dart';

class NotiCreatedDto {
  final String id;
  final String title;
  final String body;
  final String userId;
  final DateTime createdAt;
  final DateTime updatedAt;
  final bool isRead;
  final EmergencyPayload payload;

  NotiCreatedDto({
    required this.id,
    required this.title,
    required this.body,
    required this.userId,
    required this.createdAt,
    required this.updatedAt,
    required this.isRead,
    required this.payload,
  });

  factory NotiCreatedDto.fromJson(Map<String, dynamic> json) {
    final data = json['payload'];

    return NotiCreatedDto(
      id: data['id'].toString(),
      title: data['title'],
      body: data['body'],
      userId: data['userId'].toString(),
      createdAt: DateTime.parse(data['createdAt']),
      updatedAt: DateTime.parse(data['updatedAt']),
      isRead: data['isRead'] ?? false,
      payload: EmergencyPayload.fromJson(data['data']['payload']),
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
    final coordinates = json['position']['coordinates'] as List;
    return EmergencyPayload(
      id: json['id'].toString(),
      name: json['name'],
      position: LatLng(
        (coordinates[1] as num).toDouble(), // latitude
        (coordinates[0] as num).toDouble(), // longitude
      ),
      status: json['status'],
      lastUpdate: json['lastUpdate'],
      userId: json['userId'].toString(),
    );
  }
}
