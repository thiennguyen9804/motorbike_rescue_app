import 'package:dartz/dartz.dart';
import 'package:motorbike_rescue_app/core/usecases/usecase.dart';
import 'package:motorbike_rescue_app/data/dto/auth_email_login_dto.dart';
import 'package:motorbike_rescue_app/data/dto/log_in_res.dart';

class LoginUseCase implements UseCase<Either<String, LogInRes>, AuthEmailLoginDto> {
  final loginRes = LogInRes();
  @override
  Future<Either<String, LogInRes>> call({AuthEmailLoginDto? param}) async {
    await Future.delayed(Duration(seconds: 2));
    return Right(loginRes);
  }
  
}