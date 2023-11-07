import 'package:firebase_auth/firebase_auth.dart';

class FrontendUser {
  final dynamic userInfo;
  final User? user;
  final String password;
  const FrontendUser(
      {required this.userInfo, required this.user, required this.password});
}
