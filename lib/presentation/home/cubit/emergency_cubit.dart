import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_polyline_algorithm/google_polyline_algorithm.dart';
import 'package:latlong2/latlong.dart';
import 'package:motorbike_rescue_app/core/constant/network_constant.dart';
import 'package:motorbike_rescue_app/core/localize.dart';
import 'package:motorbike_rescue_app/core/mapper/lat_lng_x.dart';
import 'package:motorbike_rescue_app/core/mapper/list_num_x.dart';
import 'package:motorbike_rescue_app/core/mapper/position_x.dart';
import 'package:motorbike_rescue_app/core/network/dio_client.dart';
import 'package:motorbike_rescue_app/data/dto/noti_created_dto.dart';
import 'package:motorbike_rescue_app/data/services/listen_emergency_service.dart';
import 'package:motorbike_rescue_app/presentation/home/data/instruction_ui.dart';
import 'package:motorbike_rescue_app/sl.dart';

part 'emergency_state.dart';

// Cubit để listen khi có những người xung quanh bị tai nạn
class EmergencyCubit extends Cubit<EmergencyState> {
  EmergencyCubit() : super(EmergencyInitial()) {
    sl<ListenEmergencyService>()
        .listenForEmergency((NotiCreatedDto notCreatedDto) {
      final destination = notCreatedDto.payload.position;
      handleEmergency(destination);
    });
  }

  void handleEmergency(final LatLng destination) async {
    emit(EmergencyHappened(destination));

    await fetchRoute(destination);
  }

  @protected
  Future<Position> getCurrentPosition() async =>
      await Geolocator.getCurrentPosition();

  Future<void> fetchRoute(LatLng destination) async {
    final my = await getCurrentPosition();
    // final my = LatLng()
    if (kDebugMode) {
      print('📍 My location: (${my.latitude}, ${my.longitude})');
    }

    final LatLng startLocation = my.toLatLng();
    // final LatLng startLocation = LatLng(10.8769684, 106.8093181);

    final polylines = encodePolyline([
      startLocation.toArr(),
      destination.toArr(),
    ]);
    try {
      final res = await sl<DioClient>()
          .get(ServerNetworkConstant.routingUrl(polylines));
      final data = res.data;
      String geo = data['routes'][0]['geometry'];
      final temp = decodePolyline(geo);
      final points = temp.map((item) => item.toLatLng()).toList();
      final List<InstructionUi> instructions = parseInstructions(data);

      emit(RouteFetched(points, instructions));
      debugPrint('points: $points');
    } on DioException catch (e) {
      debugPrint('http error message: ${e.message}');
      debugPrint(
          'status code ${e.response?.statusCode ?? 'unknown status code'}');
      debugPrint("❌ Lỗi kết nối API OSRM: $e");
    } catch (e) {
      debugPrint("Lỗi: $e");
    }
  }

  List<InstructionUi> parseInstructions(Map<String, dynamic> osrmData) {
    final steps = osrmData['routes'][0]['legs'][0]['steps'] as List;

    final res = List.generate(steps.length, (index) {
      final currentStep = steps[index];
      final nextStep = steps[index];
      final nextLoc = nextStep['maneuver']['location']; // [lng, lat]
      final LatLng destination = LatLng(nextLoc[1], nextLoc[0]);

      final res = InstructionUi(
        distance: (currentStep['distance'] as num).toDouble(),
        text: getVietnameseInstruction(currentStep),
        destination: destination,
      );
      return res;
    });
    print('Emeregency Cubit parseInstructions $res');
    return res;
  }
}
