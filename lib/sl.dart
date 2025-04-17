import 'package:get_it/get_it.dart';
import 'package:motorbike_rescue_app/core/network/dio_client.dart';
import 'package:motorbike_rescue_app/data/repository/auth_repository.dart';
import 'package:motorbike_rescue_app/data/services/auth_api_service.dart';
import 'package:motorbike_rescue_app/data/services/auth_local_service.dart';
import 'package:motorbike_rescue_app/domain/login_use_case.dart';

final sl = GetIt.instance;

void setUpServiceLocator() {
  setUpDio();
  setUpUseCase();
  setUpRepo();
  setUpService();
}

void setUpDio() {
  sl.registerSingleton<DioClient>(DioClient());
}

void setUpUseCase() {
  sl.registerSingleton<LoginUseCase>(LoginUseCase());
}

void setUpRepo() {
  sl.registerSingleton<AuthRepository>(AuthRepositoryImpl());
}

void setUpService() {
  sl.registerSingleton<AuthApiService>(AuthApiServiceImpl());
  sl.registerSingleton<AuthLocalService>(AuthLocalServiceImpl());
}
