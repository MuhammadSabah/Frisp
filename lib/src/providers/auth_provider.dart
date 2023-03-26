import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:food_recipe_final/src/models/user_model.dart';

class AppTab {
  static const int discover = 0;
  static const int search = 1;
  static const int create = 2;
  static const int shopping = 3;
  static const int profile = 4;
}

class AuthProvider extends ChangeNotifier {
  final FirebaseFirestore _firestore;
  final FirebaseAuth _userAuth;
  AuthProvider(this._userAuth, this._firestore);

  int _selectedTab = AppTab.discover;
  UserModel? user;

  int get selectedTab => _selectedTab;

  Future<String?> signUpUser({
    required userName,
    required userEmail,
    required userPassword,
  }) async {
    String errorResult = 'Error occurred';
    try {
      UserCredential userCred = await _userAuth.createUserWithEmailAndPassword(
          email: userEmail, password: userPassword);
      user = UserModel(
        id: _userAuth.currentUser!.uid,
        userName: userName,
        email: userEmail,
        photoUrl: "",
        bio: '',
        followers: [],
        following: [],
      );

      await _firestore
          .collection('users')
          .doc(userCred.user!.uid)
          .set(user!.toJson());
      notifyListeners();

      return null;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        errorResult = 'The password provided is too weak.';
      } else if (e.code == 'email-already-in-use') {
        errorResult = 'An account already exists for that email.';
      } else if (e.code == 'invalid-email') {
        errorResult = 'Email is invalid.';
      } else {
        debugPrint(e.toString());
      }
      return errorResult;
    } catch (e) {
      return e.toString();
    }
  }

  Future<String?> logInUser({
    required String userEmail,
    required String userPassword,
  }) async {
    String errorResult = 'Error occurred';
    try {
      await _userAuth.signInWithEmailAndPassword(
        email: userEmail,
        password: userPassword,
      );

      notifyListeners();
      return null;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'wrong-password') {
        errorResult = 'Password is incorrect.';
      } else if (e.code == 'user-not-found') {
        errorResult = 'User is not registered.';
      } else if (e.code == 'invalid-email') {
        errorResult = 'Invalid email.';
      }

      return errorResult;
    } catch (e) {
      return e.toString();
    }
  }

  void gotToTab(int tabIndex) {
    _selectedTab = tabIndex;
    notifyListeners();
  }

  Future<void> logOutUser() async {
    await _userAuth.signOut();
    _selectedTab = 0;
    notifyListeners();
  }

  Future<String?> forgetPassword({required String email}) async {
    String errorResult = 'Error Occurred';
    try {
      await _userAuth.sendPasswordResetEmail(email: email);
      return null;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'missing-continue-uri') {
        errorResult = 'Missing continue uri.';
      } else if (e.code == 'user-not-found') {
        errorResult = 'User is not registered.';
      } else if (e.code == 'invalid-email') {
        errorResult = 'Invalid email.';
      } else if (e.code == 'missing-ios-bundle-id') {
        errorResult = 'Missing iOS bundle id.';
      } else if (e.code == 'invalid-continue-uri') {
        errorResult = 'Invalid continue URI.';
      } else if (e.code == 'unauthorized-continue-uri.') {
        errorResult = 'Unauthorized continue URI.';
      }

      notifyListeners();
      return errorResult;
    } catch (e) {
      return e.toString();
    }
  }
}
