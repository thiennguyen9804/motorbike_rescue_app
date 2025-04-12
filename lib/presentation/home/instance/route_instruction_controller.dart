import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';
import 'package:motorbike_rescue_app/presentation/home/data/instruction_ui.dart';

class RouteInstructionController {
  final List<InstructionUi> _instructions;
  final void Function(List<InstructionUi>) onUpdate;
  late StreamSubscription<Position> _positionStream;
  int _currentIndex = 0;

  RouteInstructionController({
    required List<InstructionUi> instructions,
    required this.onUpdate,
  }) : _instructions = instructions {
    startListening();
  }

  @protected
  void startListening() {
    _positionStream = Geolocator.getPositionStream().listen((position) {
      handlePositionChange(position);
    });
  }

  @protected
  void handlePositionChange(Position position) {
    if (_currentIndex >= _instructions.length - 1) return;

    final userLocation = LatLng(position.latitude, position.longitude);
    final next = _instructions[_currentIndex + 1];
    final instructionLocation = LatLng(
      next.position.latitude,
      next.position.longitude,
    );

    final distance = Distance().as(
      LengthUnit.Meter,
      userLocation,
      instructionLocation,
    );

    // Cập nhật khoảng cách đến điểm tiếp theo
    _instructions[_currentIndex + 1] = next.copyWith(distance: distance);
    onUpdate([..._instructions]);

    if (distance < 10) {
      _currentIndex++;
    }
  }

  void dispose() {
    _positionStream.cancel();
  }
}
