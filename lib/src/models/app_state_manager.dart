import 'dart:async';
import 'package:flutter/material.dart';
import 'package:food_recipe_final/src/models/app_cache.dart';

class AppTab {
  static const int discover = 0;
  static const int search = 1;
  static const int create = 2;
  static const int shopping = 3;
  static const int profile = 4;
}

class AppStateManager extends ChangeNotifier {
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
    _signedUp = false;
    _loggedIn = false;
    notifyListeners();
  }

  void goToSignUp() async {
    _signedUp = false;
    _loggedIn = false;
    notifyListeners();
  }

  void signUp(String userName, String email, String password) async {
    _signedUp = true;
    await _appCache.cacheUserSignup();
    notifyListeners();
  }

  void logIn(String email, String password) async {
    _loggedIn = true;
    await _appCache.cacheUserLogin();
    notifyListeners();
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

  void logOut() async {
    _initialized = false;
    _selectedTab = 0;
    await _appCache.invalidate();

    initializeApp();
    notifyListeners();
  }
}
