part of 'pick_time_cubit.dart';

@immutable
sealed class PickTimeState {}

final class PickTimeInitial extends PickTimeState {}

final class PickTimeSet extends PickTimeState {
  final PickedTimes pts;

  PickTimeSet({required this.pts});
}

final class PickTimeSuccess extends PickTimeInitial {
  final List<LatLng> arr;

  PickTimeSuccess({required this.arr});
}
