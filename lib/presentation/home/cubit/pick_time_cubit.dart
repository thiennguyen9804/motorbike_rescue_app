import 'package:bloc/bloc.dart';
import 'package:latlong2/latlong.dart';
import 'package:meta/meta.dart';
import 'package:motorbike_rescue_app/presentation/home/data/picked_times.dart';

part 'pick_time_state.dart';

class PickTimeCubit extends Cubit<PickTimeState> {
  PickTimeCubit() : super(PickTimeInitial());

  void setPickedTimes(PickedTimes pts) {
    emit(PickTimeSet(pts: pts));
    _fetchRoutes(pts);
  }

  void _fetchRoutes(PickedTimes pts) async {
    await Future.delayed(const Duration(seconds: 2));
    // emit()
  }
}
