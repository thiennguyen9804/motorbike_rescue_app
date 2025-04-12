import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';
import 'package:motorbike_rescue_app/core/usecases/usecase.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());

  Future execute(
    dynamic params,
    UseCase usecase
  ) async {
    emit(AuthLoading());
    final res = await usecase.call();
    res.fold(
      (message) => emit(AuthFailed(message: message)),
      (data) => emit(AuthSuccess()),
    );
  }
}
