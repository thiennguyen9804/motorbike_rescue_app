import 'package:motorbike_rescue_app/data/dto/log_in_res.dart';

class LocalUser {
  final int id;
  final String email;
  final String firstName;
  final String lastName;
  final String role;

  LocalUser({
    required this.id,
    required this.email,
    required this.firstName,
    required this.lastName,
    required this.role,
  });

  factory LocalUser.fromJson(Map<String, dynamic> json) {
    return LocalUser(
      id: json['id'],
      email: json['email'],
      firstName: json['firstName'],
      lastName: json['lastName'],
      role: json['role'],
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'email': email,
        'firstName': firstName,
        'lastName': lastName,
        'role': role,
      };

  // Tạo factory từ LogInRes
  factory LocalUser.fromLogInRes(LogInRes loginRes) {
    return LocalUser(
      id: loginRes.user.id,
      email: loginRes.user.email,
      firstName: loginRes.user.firstName,
      lastName: loginRes.user.lastName,
      role: loginRes.user.role.name,  // Role có thể là một object, cần truy xuất name
    );
  }
}