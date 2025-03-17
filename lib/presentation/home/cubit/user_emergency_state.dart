part of 'user_emergency_cubit.dart';

@immutable
sealed class UserEmergencyState {}

final class UserEmergencyInitial extends UserEmergencyState {}

final class UserEmergencyConfirm extends UserEmergencyState {}

final class UserIsEmergency extends UserEmergencyState {}

final class UserSafe extends UserEmergencyState {}
