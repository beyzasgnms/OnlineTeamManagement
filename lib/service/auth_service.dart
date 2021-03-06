import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:online_team_management/model/User.dart';
import 'package:online_team_management/service/user_service.dart';

class AuthService {
  static final FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  Future<AuthResult> signUp(
      {@required String email, @required String password}) async {
    try {
      return await firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);
    } catch (e) {
      return null;
    }
  }

  Future<bool> login(
      {@required String email, @required String password}) async {
    try {
      AuthResult authResult = await firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);

      if (authResult.user != null) {
        return true;
      }
      return false;
    } catch (e) {
      print("DEBUG: $e");
      return false;
    }
  }

  Future<User> currentUser() async {
    FirebaseUser currentUser = await firebaseAuth.currentUser();

    if (currentUser != null) {
      User user = await UserService().searchUser(currentUser.uid);
      return user;
    }
    return null;
  }

  Future<String> currentUserId() async {
    FirebaseUser currentUser = await firebaseAuth.currentUser();

    if (currentUser != null) {
      return currentUser.uid;
    }
    return null;
  }

  Future<bool> singOut() async {
    try {
      await firebaseAuth.signOut();
      return true;
    } catch (e) {
      print("Sign out hata:" + e.toString());
      return false;
    }
  }
}
