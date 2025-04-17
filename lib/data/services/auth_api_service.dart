import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:motorbike_rescue_app/core/constant/network_constant.dart';
import 'package:motorbike_rescue_app/core/network/dio_client.dart';
import 'package:motorbike_rescue_app/data/dto/auth_email_login_dto.dart';
import 'package:motorbike_rescue_app/data/dto/log_in_res.dart';
import 'package:motorbike_rescue_app/sl.dart';

abstract class AuthApiService {
  Future<Either<String, LogInRes>> logIn(AuthEmailLoginDto dto);
}

class AuthApiServiceImpl implements AuthApiService {
  @override
  Future<Either<String, LogInRes>> logIn(AuthEmailLoginDto dto) async {
    try {
      final res = await sl<DioClient>().post(NetworkConstant.SIGN_IN, data: dto.toJson());
      return Right(LogInRes());
    } on DioException catch(e) {
      final data = e.response?.data;
      if(data is Map<String, dynamic>) {
        final errors = data['errors'];
        final email = errors['email'];
        final password = errors['password'];
        if(email != null && email == 'notFound') {
          return Left('Tài khoản không tồn tại');
        } else if(password != null && password == 'incorrectPassword') {
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

}
