import 'package:get_it/get_it.dart';
import 'package:motorbike_rescue_app/core/network/dio_client.dart';
import 'package:motorbike_rescue_app/core/network/socket_client.dart';
import 'package:motorbike_rescue_app/data/repository/auth_repository.dart';
import 'package:motorbike_rescue_app/data/services/auth_api_service.dart';
import 'package:motorbike_rescue_app/data/services/auth_local_service.dart';
import 'package:motorbike_rescue_app/data/services/listen_emergency_service.dart';
import 'package:motorbike_rescue_app/data/services/location_service.dart';
import 'package:motorbike_rescue_app/domain/login_use_case.dart';

final sl = GetIt.instance;

void setUpServiceLocator() {
  setUpService();
  setUpNetwork();
  setUpUseCase();
  setUpRepo();
}

void setUpNetwork() {
  sl.registerSingleton<DioClient>(DioClient());
  sl.registerLazySingleton<SocketClient>(() {
    final token = sl<AuthLocalService>().getTokens();
    final socketClient = SocketClient()..authToken = token.token;
    socketClient.initSocket();
    return socketClient;
  });
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
  sl.registerSingleton<LocationService>(LocationServiceImpl());
  sl.registerSingleton<ListenEmergencyService>(ListenEmergencyServiceImpl());
}
