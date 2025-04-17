import 'dart:convert';

import 'package:motorbike_rescue_app/data/dto/log_in_res.dart';

class Tokens {
  final String refreshToken;
  final String token;
  final int tokenExpires;

  Tokens({
    required this.refreshToken,
    required this.token,
    required this.tokenExpires,
  });

  Tokens copyWith({
    String? refreshToken,
    String? token,
    int? tokenExpires,
  }) {
    return Tokens(
      refreshToken: refreshToken ?? this.refreshToken,
      token: token ?? this.token,
      tokenExpires: tokenExpires ?? this.tokenExpires,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'refreshToken': refreshToken,
      'token': token,
      'tokenExpires': tokenExpires,
    };
  }

  factory Tokens.fromMap(Map<String, dynamic> map) {
    return Tokens(
      refreshToken: map['refreshToken'] as String,
      token: map['token'] as String,
      tokenExpires: map['tokenExpires'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory Tokens.fromJson(String source) => Tokens.fromMap(json.decode(source) as Map<String, dynamic>);

  // Tạo factory từ LogInRes
  factory Tokens.fromLogInRes(LogInRes loginRes) {
    return Tokens(
      refreshToken: loginRes.refreshToken,
      token: loginRes.token,
      tokenExpires: loginRes.tokenExpires,
    );
  }

  @override
  String toString() => 'Tokens(refreshToken: $refreshToken, token: $token, tokenExpires: $tokenExpires)';

  @override
  bool operator ==(covariant Tokens other) {
    if (identical(this, other)) return true;
  
    return 
      other.refreshToken == refreshToken &&
      other.token == token &&
      other.tokenExpires == tokenExpires;
  }

  @override
  int get hashCode => refreshToken.hashCode ^ token.hashCode ^ tokenExpires.hashCode;
}
