import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:motorbike_rescue_app/data/dto/auth_email_login_dto.dart';
import 'package:motorbike_rescue_app/data/dto/local_user.dart';
import 'package:motorbike_rescue_app/data/dto/log_in_res.dart';
import 'package:motorbike_rescue_app/data/dto/tokens.dart';
import 'package:motorbike_rescue_app/data/services/auth_api_service.dart';
import 'package:motorbike_rescue_app/data/services/auth_local_service.dart';
import 'package:motorbike_rescue_app/exception/no_tokens_exceptions.dart';
import 'package:motorbike_rescue_app/sl.dart';

abstract class AuthRepository {
  Future<Either<String, LogInRes>> logIn(AuthEmailLoginDto login);
  Future<void> refreshTokens(Tokens refreshTokens);
  Tokens getTokens();
  Future<String?> register();
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

  @override
  Future<void> refreshTokens(Tokens refreshTokens) async {
    final newTokens = await sl<AuthApiService>().getNewTokens(refreshTokens);
    sl<AuthLocalService>().writeTokens(newTokens);
  }

  @override
  Tokens getTokens() {
    try {
      final res = sl<AuthLocalService>().getTokens();
      return res;
    } on NoTokensExceptions catch (e) {
      rethrow;
    }
  }

  @override
  Future<String?> register() async {}
}
