import 'package:geolocator/geolocator.dart';
import 'package:motorbike_rescue_app/presentation/home/cubit/emergency_cubit.dart';

class MockEmergencyCubit extends EmergencyCubit {
  @override
  Future<Position> getCurrentPosition() async {
  Future.delayed(const Duration(milliseconds: 0));
    return Position(
      longitude: 106.80875890345213,
      latitude: 10.877513765586913,
      timestamp: DateTime.now(),
      accuracy: 0,
      altitude: 0,
      heading: 0,
      speed: 0,
      speedAccuracy: 0,
      headingAccuracy: 0,
      altitudeAccuracy: 0,
    );
  }
}
