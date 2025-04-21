// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class AuthRegisterLoginDto {
  final String email;
  final String password;
  final String firstName;
  final String lastName;

  AuthRegisterLoginDto({
    required this.email,
    required this.password,
    required this.firstName,
    required this.lastName,
  });

  AuthRegisterLoginDto copyWith({
    String? email,
    String? password,
    String? firstName,
    String? lastName,
  }) {
    return AuthRegisterLoginDto(
      email: email ?? this.email,
      password: password ?? this.password,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'email': email,
      'password': password,
      'firstName': firstName,
      'lastName': lastName,
    };
  }

  factory AuthRegisterLoginDto.fromMap(Map<String, dynamic> map) {
    return AuthRegisterLoginDto(
      email: map['email'] as String,
      password: map['password'] as String,
      firstName: map['firstName'] as String,
      lastName: map['lastName'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory AuthRegisterLoginDto.fromJson(String source) => AuthRegisterLoginDto.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'AuthRegisterLoginDto(email: $email, password: $password, firstName: $firstName, lastName: $lastName)';
  }

  @override
  bool operator ==(covariant AuthRegisterLoginDto other) {
    if (identical(this, other)) return true;
  
    return 
      other.email == email &&
      other.password == password &&
      other.firstName == firstName &&
      other.lastName == lastName;
  }

  @override
  int get hashCode {
    return email.hashCode ^
      password.hashCode ^
      firstName.hashCode ^
      lastName.hashCode;
  }
}
