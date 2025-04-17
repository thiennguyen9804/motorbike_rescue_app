import 'package:motorbike_rescue_app/data/dto/role.dart';
import 'package:motorbike_rescue_app/data/dto/status.dart';

class UserDto {
  final int id;
  final String email;
  final String provider;
  final String? socialId;
  final String firstName;
  final String lastName;
  final Role role;
  final Status status;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String? deletedAt;

  UserDto({
    required this.id,
    required this.email,
    required this.provider,
    this.socialId,
    required this.firstName,
    required this.lastName,
    required this.role,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
  });

  factory UserDto.fromJson(Map<String, dynamic> json) {
    return UserDto(
      id: json['id'],
      email: json['email'],
      provider: json['provider'],
      socialId: json['socialId'],
      firstName: json['firstName'],
      lastName: json['lastName'],
      role: Role.fromJson(json['role']),
      status: Status.fromJson(json['status']),
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
      deletedAt: json['deletedAt'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'provider': provider,
      'socialId': socialId,
      'firstName': firstName,
      'lastName': lastName,
      'role': role.toJson(),
      'status': status.toJson(),
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
      'deletedAt': deletedAt,
    };
  }
}
