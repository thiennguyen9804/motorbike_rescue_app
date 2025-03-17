import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'emergency_state.dart';

class EmergencyCubit extends Cubit<EmergencyState> {
  EmergencyCubit() : super(EmergencyInitial());

  void listenForEmergency() async {
    // Future.delayed(const Duration(seconds: 3), () {
    //   emit(EmergencyHappened());
    // });
  }
}
