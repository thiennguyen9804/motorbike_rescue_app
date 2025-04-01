import 'package:get_it/get_it.dart';
import 'package:motorbike_rescue_app/core/network/dio_client.dart';

final sl = GetIt.instance;

void setUpServiceLocator() {
  setUpDio();
}

void setUpDio() {
  sl.registerSingleton<DioClient>(DioClient());
}
