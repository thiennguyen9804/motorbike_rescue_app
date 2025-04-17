import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:motorbike_rescue_app/data/dto/auth_email_login_dto.dart';
import 'package:motorbike_rescue_app/data/dto/log_in_res.dart';
import 'package:motorbike_rescue_app/data/services/auth_api_service.dart';
import 'package:motorbike_rescue_app/sl.dart';

abstract class AuthRepository {
  Future<Either<String, LogInRes>> logIn(AuthEmailLoginDto login);
}

class AuthRepositoryImpl implements AuthRepository {
  @override
  Future<Either<String, LogInRes>> logIn(AuthEmailLoginDto login) async {
    return await sl<AuthApiService>().logIn(login);    
  }

}