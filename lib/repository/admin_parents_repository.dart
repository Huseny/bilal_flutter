import 'package:bilal/models/parent_model.dart';
import 'package:bilal/utils/generator.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AdminParentsRepository {
  AdminParentsRepository();

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  Future<List<Parent>> getParents() async {
    List<Parent> parents = [];
    await _firebaseFirestore.collection("parents").get().then(
      (querySnapshot) {
        for (var docSnapshot in querySnapshot.docs) {
          Map<String, dynamic> data = docSnapshot.data();
          parents.add(Parent.fromFirestore(data));
        }
      },
      onError: (e) => throw Exception(e),
    );
    return parents;
  }

  Future<List<dynamic>> createParent(
    String name,
    String sex,
    String phone,
    String? email,
    String address,
  ) async {
    final String userEmail = email ?? Generator.generateEmail(name);
    final String password = Generator.generatePassword();
    try {
      UserCredential userCredential = await _firebaseAuth
          .createUserWithEmailAndPassword(email: userEmail, password: password);

      await _firebaseFirestore
          .collection("parents")
          .doc(userCredential.user!.uid)
          .set({
        "uid": userCredential.user!.uid,
        "name": name,
        "username": userEmail.split('@')[0],
        "sex": sex == "M" ? "ذكر" : "أنثى",
        "phone": phone,
        "email": email ?? "",
        "address": address
      });
      return [userCredential.user!, password];
    } on Exception catch (_) {
      rethrow;
    }
  }

  Future<void> editParent({
    required String parentId,
    required String name,
    required String sex,
    required String phone,
    required String username,
    required String? email,
    required String address,
  }) async {
    try {
      await _firebaseFirestore.collection("parents").doc(parentId).set({
        "uid": parentId,
        "name": name,
        "username": username,
        "sex": sex == "M" ? "ذكر" : "أنثى",
        "phone": phone,
        "email": email ?? "",
        "address": address
      });
    } on Exception catch (_) {
      rethrow;
    }
  }
}
