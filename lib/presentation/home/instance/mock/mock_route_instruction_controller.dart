import 'dart:async';

import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';
import 'package:motorbike_rescue_app/presentation/home/data/instruction_ui.dart';
import 'package:motorbike_rescue_app/presentation/home/instance/route_instruction_controller.dart';

class MockRouteInstructionController extends RouteInstructionController {
  final List<LatLng> mockPath;
  final Duration mockInterval;
  Timer? _mockTimer;
  int _mockIndex = 0;

  MockRouteInstructionController({
    required super.instructions,
    required super.onUpdate,
    required this.mockPath,
    this.mockInterval = const Duration(seconds: 2),
  });

  @override
  void startListening() {
    _mockTimer = Timer.periodic(mockInterval, (_) {
      if (_mockIndex >= mockPath.length) {
        _mockTimer?.cancel();
        return;
      }
      final loc = mockPath[_mockIndex++];
      final mockPosition = Position(
        latitude: loc.latitude,
        longitude: loc.longitude,
        timestamp: DateTime.now(),
        accuracy: 0,
        altitude: 0,
        heading: 0,
        speed: 0,
        speedAccuracy: 0,
        headingAccuracy: 0,
        altitudeAccuracy: 0,
      );
      handlePositionChange(mockPosition);
    });
  }

  @override
  void dispose() {
    _mockTimer?.cancel();
    super.dispose();
  }
}
