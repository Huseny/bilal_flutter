import 'package:firebase_auth/firebase_auth.dart';

class FrontendUser {
  final User? user;
  final String password;
  const FrontendUser({required this.user, required this.password});
}
