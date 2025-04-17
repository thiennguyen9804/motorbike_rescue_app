import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:motorbike_rescue_app/data/dto/auth_email_login_dto.dart';
import 'package:motorbike_rescue_app/data/dto/local_user.dart';
import 'package:motorbike_rescue_app/data/dto/log_in_res.dart';
import 'package:motorbike_rescue_app/data/dto/tokens.dart';
import 'package:motorbike_rescue_app/data/services/auth_api_service.dart';
import 'package:motorbike_rescue_app/data/services/auth_local_service.dart';
import 'package:motorbike_rescue_app/sl.dart';

abstract class AuthRepository {
  Future<Either<String, LogInRes>> logIn(AuthEmailLoginDto login);
}

class AuthRepositoryImpl implements AuthRepository {
  @override
  Future<Either<String, LogInRes>> logIn(AuthEmailLoginDto login) async {
    final either = await sl<AuthApiService>().logIn(login);
    return either.fold(
      (error) => Left(error),
      (loginRes) {
        final tokens = Tokens.fromLogInRes(loginRes);
        final localUser = LocalUser.fromLogInRes(loginRes);
        sl<AuthLocalService>().writeTokens(tokens);
        sl<AuthLocalService>().writeUserToLocal(localUser);
        return Right(loginRes);
      },
    );
  }
}
