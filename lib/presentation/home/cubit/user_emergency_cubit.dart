import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'user_emergency_state.dart';

class UserEmergencyCubit extends Cubit<UserEmergencyState> {
  UserEmergencyCubit() : super(UserEmergencyInitial());

  listenForUserEmergency() async {
    Future.delayed(const Duration(seconds: 3), () {
      emit(UserEmergencyConfirm());
    });
  }
}
