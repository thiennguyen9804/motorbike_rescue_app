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
    if (_currentIndex >= _instructions.length) return;

    final userLocation = LatLng(position.latitude, position.longitude);
    final current = _instructions[_currentIndex];
    final instructionLocation = LatLng(current.destination.latitude, current.destination.longitude);

    final distance = Distance().as(LengthUnit.Meter, userLocation, instructionLocation);

    // Cập nhật UI
    _instructions[_currentIndex] = current.copyWith(distance: distance);
    onUpdate([..._instructions]);

    if (distance < 10 && _currentIndex < _instructions.length - 1) {
      _currentIndex++;
    }
  }

  void dispose() {
    _positionStream.cancel();
  }
}
