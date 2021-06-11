import 'package:booking/domain/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

class AuthService {
  final FirebaseAuth _fAuth = FirebaseAuth.instance;

  Future<UserData> signIn(String email, String password) async {
    try {
      UserCredential result = (await _fAuth.signInWithEmailAndPassword(
          email: email, password: password));
      User user = FirebaseAuth.instance.currentUser;

      return UserData.fromFirebase(user);
    } catch (e) {
      debugPrint(e);
    }
  }

  Future<UserData> register(String email, String password) async {
    try {
      UserCredential result = (await _fAuth.createUserWithEmailAndPassword(
          email: email, password: password));
      User user = FirebaseAuth.instance.currentUser;

      return UserData.fromFirebase(user);
    } catch (e) {
      debugPrint(e);
    }
  }

  Future logOut() async {
    await _fAuth.signOut();
  }

  Stream<UserData> get currentUser {
    return _fAuth
        .authStateChanges()
        .map((User user) => user != null ? UserData.fromFirebase(user) : null);
  }
}
