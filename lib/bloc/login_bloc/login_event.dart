import 'package:equatable/equatable.dart';

abstract class LoginEvent extends Equatable {
  const LoginEvent();
}

class LoadLogin extends LoginEvent {
  @override
  List<Object?> get props => [];
}

class LoginWithCredentials extends LoginEvent {
  final String email;
  final String password;

  const LoginWithCredentials({required this.email, required this.password});

  @override
  List<Object?> get props => [email, password];
}

class LogOut extends LoginEvent {
  @override
  List<Object?> get props => [];
}
