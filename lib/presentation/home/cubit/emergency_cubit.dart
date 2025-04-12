import 'dart:convert';

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
import 'package:motorbike_rescue_app/presentation/home/data/instruction_ui.dart';
import 'package:motorbike_rescue_app/sl.dart';

part 'emergency_state.dart';

class EmergencyCubit extends Cubit<EmergencyState> {
  EmergencyCubit() : super(EmergencyInitial());

  void listenForEmergency() async {
    await Future.delayed(const Duration(seconds: 5)); // Giả lập sự kiện tai nạn
    final destination = LatLng(10.885145, 106.805006);

    emit(EmergencyHappened(destination));

    await fetchRoute(destination);
  }

  Future<void> fetchRoute(LatLng destination) async {
    final my = await Geolocator.getCurrentPosition();
    if (kDebugMode) {
      print('📍 My location: (${my.latitude}, ${my.longitude})');
    }

    final LatLng startLocation = my.toLatLng();
    final polylines = encodePolyline([
      startLocation.toArr(),
      destination.toArr(),
    ]);
    try {
      final res =
          await sl<DioClient>().get(NetworkConstant.routingUrl(polylines));
      final data = res.data;
      String geo = data['routes'][0]['geometry'];
      final temp = decodePolyline(geo);
      final points = temp.map((item) => item.toLatLng()).toList();
      final List<InstructionUi> instructions = parseInstructions(data);

      emit(RouteFetched(points, instructions));
      print('points: $points');
    } on DioException catch (e) {
      print('http error message: ${e.message}');
      print('status code ${e.response?.statusCode ?? 'unknown status code'}');
      print("❌ Lỗi kết nối API OSRM: $e");
    } catch (e) {
      print("Lỗi: $e");
    }
  }

  List<InstructionUi> parseInstructions(Map<String, dynamic> osrmData) {
    final steps = osrmData['routes'][0]['legs'][0]['steps'] as List;

    return List.generate(steps.length - 1, (index) {
      final currentStep = steps[index];
      final nextStep = steps[index + 1];
      final nextLoc = nextStep['maneuver']['location']; // [lng, lat]
      final LatLng destination = LatLng(nextLoc[1], nextLoc[0]);

      return InstructionUi(
        distance: (currentStep['distance'] as num).toDouble(),
        text: getVietnameseInstruction(currentStep),
        destination: destination,
      );
    });
  }
}
