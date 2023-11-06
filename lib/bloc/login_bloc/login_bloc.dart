import 'package:bilal/repository/auth_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'login_event.dart';
import 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final AuthRepository authRepository = AuthRepository();

  LoginBloc({authRepository}) : super(const LoginInitial()) {
    on<LoadLogin>((event, emit) {
      emit(const LoginInitial());
    });

    on<LoginWithCredentials>((event, emit) async {
      if (state is LoginLoading) return;
      emit(const LoginLoading());
      try {
        User? user = await authRepository.logInWithEmailAndPassword(
            email: event.email, password: event.password);

        emit(LoginSuccess(user: user!));
      } catch (error) {
        if (error is FirebaseAuthException) {
          emit(LoginFailure(error: error));
        }
      }
    });

    on<LogOut>(
      (event, emit) async {
        if (state is LogOutLoading) return;
        emit(LogOutLoading());
        try {
          await authRepository.logOut();
          emit(LogOutSuccess());
          emit(const LoginInitial());
        } catch (error) {
          if (error is FirebaseAuthException) {
            emit(LogOutFailure(error: error));
          }
        }
      },
    );
  }
}
