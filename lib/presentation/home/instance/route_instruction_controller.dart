import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';
import 'package:motorbike_rescue_app/presentation/home/data/instruction_ui.dart';

class RouteInstructionController {
  final List<InstructionUi> _instructions;
  final void Function(List<InstructionUi>, int) onUpdate;
  final double distanceThreshold; // ← Thêm ngưỡng chuyển bước
  late StreamSubscription<Position> _positionStream;
  int _currentIndex = 0;

  RouteInstructionController({
    required List<InstructionUi> instructions,
    required this.onUpdate,
    this.distanceThreshold = 15.0, // ← Có thể điều chỉnh (mặc định 15m)
  }) : _instructions = instructions {
    startListening();
  }

  void startListening() {
    _positionStream = Geolocator.getPositionStream().listen((position) {
      handlePositionChange(position);
    });
  }

  void handlePositionChange(Position position) {
    if (_currentIndex >= _instructions.length) return;

    final userLocation = LatLng(position.latitude, position.longitude);
    final currentStep = _instructions[_currentIndex];
    final maneuverLocation = LatLng(
      currentStep.destination.latitude,
      currentStep.destination.longitude,
    );

    final distance = Distance().as(
      LengthUnit.Meter,
      userLocation,
      maneuverLocation,
    );

    // Cập nhật khoảng cách cho step hiện tại
    _instructions[_currentIndex] =
        currentStep.copyWith(distance: distance);
    onUpdate([..._instructions], _currentIndex);

    // Nếu user đủ gần với maneuver point -> chuyển step
    if (distance < distanceThreshold &&
        _currentIndex < _instructions.length - 1) {
      _currentIndex++;
      // Gọi lại onUpdate để UI biết đã chuyển sang bước tiếp theo
      onUpdate([..._instructions], _currentIndex);
    }
  }

  void dispose() {
    _positionStream.cancel();
  }
}
