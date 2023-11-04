import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract class LoginState extends Equatable {
  const LoginState();
}

class LoginInitial extends LoginState {
  const LoginInitial();

  @override
  List<Object?> get props => [];
}

class LoginLoading extends LoginState {
  const LoginLoading();

  @override
  List<Object?> get props => [];
}

class LoginSuccess extends LoginState {
  final User user;
  const LoginSuccess({required this.user});

  @override
  List<Object?> get props => [user.uid, user.displayName, user.email];
}

class LoginFailure extends LoginState {
  final Object error;

  const LoginFailure({required this.error});

  @override
  List<Object?> get props => [error];
}

class LogOutLoading extends LoginState {
  @override
  List<Object?> get props => [];
}

class LogOutSuccess extends LoginState {
  @override
  List<Object?> get props => [];
}

class LogOutFailure extends LoginState {
  final Object error;

  const LogOutFailure({required this.error});

  @override
  List<Object?> get props => [error];
}
