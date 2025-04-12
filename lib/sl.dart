import 'package:get_it/get_it.dart';
import 'package:motorbike_rescue_app/core/network/dio_client.dart';
import 'package:motorbike_rescue_app/domain/login_use_case.dart';

final sl = GetIt.instance;

void setUpServiceLocator() {
  setUpDio();
  setUpUseCase();
}

void setUpDio() {
  sl.registerSingleton<DioClient>(DioClient());
}

void setUpUseCase() {
  sl.registerSingleton<LoginUseCase>(LoginUseCase());
}

