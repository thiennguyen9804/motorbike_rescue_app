
import 'package:motorbike_rescue_app/data/dto/user_dto.dart';

class LogInRes {
  final String refreshToken;
  final String token;
  final int tokenExpires;
  final UserDto user;

  LogInRes({
    required this.refreshToken,
    required this.token,
    required this.tokenExpires,
    required this.user,
  });

  factory LogInRes.fromJson(Map<String, dynamic> json) {
    return LogInRes(
      refreshToken: json['refreshToken'],
      token: json['token'],
      tokenExpires: json['tokenExpires'],
      user: UserDto.fromJson(json['user']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'refreshToken': refreshToken,
      'token': token,
      'tokenExpires': tokenExpires,
      'user': user.toJson(),
    };
  }
}
