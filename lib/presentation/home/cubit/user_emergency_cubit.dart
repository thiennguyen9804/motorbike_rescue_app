import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'user_emergency_state.dart';

// Cubit khi bạn (người dùng) bị tai nạn
class UserEmergencyCubit extends Cubit<UserEmergencyState> {
  UserEmergencyCubit() : super(UserEmergencyInitial());

  listenForUserEmergency() async {
    Future.delayed(const Duration(seconds: 5), () {
      emit(UserEmergencyConfirm());
    });
  }
}
