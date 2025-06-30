import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:motorbike_rescue_app/core/constant/network_constant.dart';
import 'package:motorbike_rescue_app/core/network/dio_client.dart';
import 'package:motorbike_rescue_app/data/dto/auth_email_login_dto.dart';
import 'package:motorbike_rescue_app/data/dto/auth_register_login_dto.dart';
import 'package:motorbike_rescue_app/data/dto/log_in_res.dart';
import 'package:motorbike_rescue_app/data/dto/tokens.dart';
import 'package:motorbike_rescue_app/sl.dart';

abstract class AuthApiService {
  Future<Either<String, LogInRes>> logIn(AuthEmailLoginDto dto);
  Future<Tokens> getNewTokens(Tokens tokens);
  Future<String?> signUp(AuthRegisterLoginDto dto);
}

class AuthApiServiceImpl implements AuthApiService {
  @override
  Future<Either<String, LogInRes>> logIn(AuthEmailLoginDto dto) async {
    try {
      final res = await sl<DioClient>().post(
        ServerNetworkConstant.SIGN_IN,
        data: dto.toJson(),
      );
      final loginRes = LogInRes.fromJson(res.data);
      return Right(loginRes);
    } on DioException catch (e) {
      final data = e.response?.data;
      if (data is Map<String, dynamic>) {
        final errors = data['errors'];
        final email = errors['email'];
        final password = errors['password'];
        if (email != null && email == 'notFound') {
          return Left('Tài khoản không tồn tại');
        } else if (password != null && password == 'incorrectPassword') {
          return Left('Sai mật khẩu');
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }

    return Left("Đã có lỗi xảy ra");
  }

  @override
  Future<Tokens> getNewTokens(Tokens tokens) async {
    final res = await sl<DioClient>()
        .post(ServerNetworkConstant.TOKENS, data: tokens.toJson());
    final newTokens = Tokens.fromJson(res.data);
    return newTokens;
  }

  @override
  Future<String?> signUp(AuthRegisterLoginDto dto) async {
    try {
      final res = await sl<DioClient>()
          .post(ServerNetworkConstant.SIGN_UP, data: dto.toJson());
      final loginRes = LogInRes.fromJson(res.data);
      return null;
    } on DioException catch (e) {
      // final data = e.response?.data;
      // if (data is Map<String, dynamic>) {
      //   final errors = data['errors'];
      //   final email = errors['email'];
      //   final password = errors['password'];
      //   if (email != null && email == 'notFound') {
      //     return Left('Tài khoản không tồn tại');
      //   } else if (password != null && password == 'incorrectPassword') {
      //     return Left('Sai mật khẩu');
      //   }
      // }
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }

    return "Đã có lỗi xảy ra";
  }
}
