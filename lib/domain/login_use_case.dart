import 'package:dartz/dartz.dart';
import 'package:motorbike_rescue_app/core/usecases/usecase.dart';
import 'package:motorbike_rescue_app/data/dto/auth_email_login_dto.dart';
import 'package:motorbike_rescue_app/data/dto/log_in_res.dart';
import 'package:motorbike_rescue_app/data/repository/auth_repository.dart';
import 'package:motorbike_rescue_app/sl.dart';

class LoginUseCase implements UseCase<Either<String, LogInRes>, AuthEmailLoginDto> {
  final loginRes = LogInRes();

  @override
  Future<Either<String, LogInRes>> call({AuthEmailLoginDto? param}) async {
    final res = await sl<AuthRepository>().logIn(param!);

    res.fold(
      (left) {
        print('[LoginUseCase] Đăng nhập thất bại: $left');
      },
      (right) {
        print('[LoginUseCase] Đăng nhập thành công: $right');
      },
    );

    return res;
  }
}
