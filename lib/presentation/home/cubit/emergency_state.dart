part of 'emergency_cubit.dart';

@immutable
sealed class EmergencyState {}

final class EmergencyInitial extends EmergencyState {}

final class EmergencyHappened extends EmergencyState {
  final LatLng emergencyPoint;

  EmergencyHappened(this.emergencyPoint);
}

final class RouteFetched extends EmergencyState {
  final List<LatLng> polylinePoints;
  final List<InstructionUi> instructions;

  RouteFetched(this.polylinePoints, this.instructions);
}
