import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:food_recipe_final/core/app_cache.dart';

class AppTab {
  static const int discover = 0;
  static const int search = 1;
  static const int create = 2;
  static const int shopping = 3;
  static const int profile = 4;
}

class AppStateManager extends ChangeNotifier {
  final _auth = FirebaseAuth.instance;
  bool _initialized = false;
  bool _loggedIn = false;
  bool _signedUp = false;
  bool _onboardingComplete = false;
  int _selectedTab = AppTab.discover;
  final _appCache = AppCache();

  bool get isInitialized => _initialized;
  bool get isLoggedIn => _loggedIn;
  bool get isSignedUp => _signedUp;
  bool get isOnboardingComplete => _onboardingComplete;
  int get selectedTab => _selectedTab;

  void initializeApp() async {
    print(_auth.currentUser);
    if (_auth.currentUser == null) {
      _loggedIn = false;
      _signedUp = false;
    }
    _signedUp = await _appCache.isUserSignedUp();
    _loggedIn = await _appCache.isUserLoggedIn();
    _onboardingComplete = await _appCache.didCompleteOnboarding();

    Timer(
      const Duration(milliseconds: 2200),
      () {
        _initialized = true;
        notifyListeners();
      },
    );
  }

  void goToLogIn() async {
    _signedUp = true;
    _loggedIn = false;
    await _appCache.cacheUserSignup();
    await _appCache.cacheUserLogin();
    notifyListeners();
  }

  void goToSignUp() async {
    _signedUp = false;
    _loggedIn = false;
    await _appCache.cacheUserSignup();
    await _appCache.cacheUserLogin();
    notifyListeners();
  }

//  void signUp(String userName, String email, String password) async {
  // _signedUp = true;
  // await _appCache.cacheUserSignup();
//     notifyListeners();
//   }
  Future<String?> signUpUser({
    required userName,
    required userEmail,
    required userPassword,
  }) async {
    String errorResult = 'Error occurred';
    try {
      await _auth.createUserWithEmailAndPassword(
          email: userEmail, password: userPassword);
      notifyListeners();
      _signedUp = true;
      await _appCache.cacheUserSignup();
      return null;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        errorResult = 'The password provided is too weak.';
      } else if (e.code == 'email-already-in-use') {
        errorResult = 'An account already exists for that email.';
      } else if (e.code == 'invalid-email') {
        errorResult = 'Email is invalid.';
      } else {
        print(e);
      }
      _signedUp = false;
      return errorResult;
    } catch (e) {
      print(e);
      return e.toString();
    }
  }

  // void logIn(String email, String password) async {
  // _loggedIn = true;
  // await _appCache.cacheUserLogin();
  //   notifyListeners();
  // }

  Future<String?> logInUser({
    required String userEmail,
    required String userPassword,
  }) async {
    String errorResult = 'Error occurred';
    try {
      await _auth.signInWithEmailAndPassword(
        email: userEmail,
        password: userPassword,
      );
      _loggedIn = true;
      await _appCache.cacheUserLogin();
      notifyListeners();
      return null;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'wrong-password') {
        errorResult = 'Password is incorrect.';
      } else if (e.code == 'user-not-found') {
        errorResult = 'User is not registered.';
      } else if (e.code == 'invalid-email') {
        errorResult = 'Invalid email.';
      } else {
        print(e);
      }
      _loggedIn = false;
      return errorResult;
    } catch (e) {
      print(e);
      return e.toString();
    }
  }

  void completeOnboarding() async {
    _onboardingComplete = true;
    await _appCache.completeOnboarding();
    notifyListeners();
  }

  void gotToTab(int tabIndex) {
    _selectedTab = tabIndex;
    notifyListeners();
  }

  void logOutUser() async {
    await _auth.signOut();
    _initialized = false;
    _selectedTab = 0;
    await _appCache.invalidate();

    initializeApp();
    notifyListeners();
  }
}
