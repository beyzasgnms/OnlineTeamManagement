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
      await firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<void> signOut() async {
    await firebaseAuth.signOut();
  }

  Future<User> currentUser() async {
    FirebaseUser currentUser = await firebaseAuth.currentUser();
    User user = await UserService().searchUser(currentUser.uid);
    return user;
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