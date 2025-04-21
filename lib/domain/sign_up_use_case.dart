import 'package:dartz/dartz.dart';
import 'package:motorbike_rescue_app/core/usecases/usecase.dart';
import 'package:motorbike_rescue_app/data/dto/auth_register_login_dto.dart';
import 'package:motorbike_rescue_app/data/repository/auth_repository.dart';
import 'package:motorbike_rescue_app/sl.dart';

class SignUpUseCase implements UseCase<String?, AuthRegisterLoginDto> {
  @override
  Future<String?> call({AuthRegisterLoginDto? param}) async {
    return await sl<AuthRepository>().register();
  }
  
}