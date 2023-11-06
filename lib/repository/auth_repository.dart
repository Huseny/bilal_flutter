import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:firebase_auth/firebase_auth.dart';

class AuthRepository {
  final firebase_auth.FirebaseAuth _firebaseAuth;

  AuthRepository({
    firebase_auth.FirebaseAuth? firebaseAuth,
  }) : _firebaseAuth = firebaseAuth ?? firebase_auth.FirebaseAuth.instance;

  User? get user {
    return _firebaseAuth.currentUser;
  }

  Stream<User?> get userChange {
    return _firebaseAuth.authStateChanges();
  }

  Future<User?> signup({
    required String email,
    required String password,
  }) async {
    try {
      User? user = (await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      ))
          .user;
      return user;
    } catch (_) {
      rethrow;
    }
  }

  Future<User?> logInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      User? user = (await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      ))
          .user;
      return user;
    } catch (e) {
      rethrow;
    }
  }

  Future<void> logOut() async {
    try {
      await Future.wait([
        _firebaseAuth.signOut(),
      ]);
    } catch (_) {
      rethrow;
    }
  }

  // Future<User> resetPassword(String id) async {
  //   await _firebaseAu
  // }
}
