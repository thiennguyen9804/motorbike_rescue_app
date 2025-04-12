import 'package:dartz/dartz.dart';
import 'package:motorbike_rescue_app/data/dto/log_in_res.dart';

abstract class AuthApiService {
  Future<Either<String, LogInRes>> logIn();
}
