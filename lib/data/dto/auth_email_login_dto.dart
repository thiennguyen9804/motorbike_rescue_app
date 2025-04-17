// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class AuthEmailLoginDto {
  String email;
  String password;

  AuthEmailLoginDto({
    required this.email,
    required this.password,
  });

  @override
  String toString() => 'AuthEmailLoginDto(email: $email, password: $password)';

  AuthEmailLoginDto copyWith({
    String? email,
    String? password,
  }) {
    return AuthEmailLoginDto(
      email: email ?? this.email,
      password: password ?? this.password,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'email': email,
      'password': password,
    };
  }

  factory AuthEmailLoginDto.fromMap(Map<String, dynamic> map) {
    return AuthEmailLoginDto(
      email: map['email'] as String,
      password: map['password'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory AuthEmailLoginDto.fromJson(String source) => AuthEmailLoginDto.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool operator ==(covariant AuthEmailLoginDto other) {
    if (identical(this, other)) return true;
  
    return 
      other.email == email &&
      other.password == password;
  }

  @override
  int get hashCode => email.hashCode ^ password.hashCode;
}
