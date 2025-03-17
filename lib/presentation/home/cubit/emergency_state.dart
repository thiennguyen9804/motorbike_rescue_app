part of 'emergency_cubit.dart';

@immutable
sealed class EmergencyState {}

final class EmergencyInitial extends EmergencyState {}

final class EmergencyHappened extends EmergencyState {}
