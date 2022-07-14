import 'package:shared_preferences/shared_preferences.dart';

class AppCache {
  static const kUserLogin = 'userLogin';
  static const kUserSignup = 'userSignup';
  static const kOnboarding = 'onboarding';

  Future<void> invalidate() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(kUserSignup, false);
    await prefs.setBool(kUserLogin, false);
    await prefs.setBool(kOnboarding, false);
  }

  Future<void> cacheUserSignup() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(kUserSignup, true);
  }

  Future<void> cacheUserLogin() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(kUserLogin, true);
  }

  Future<void> completeOnboarding() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(kOnboarding, true);
  }

  Future<bool> isUserSignedUp() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(kUserSignup) ?? false;
  }

  Future<bool> isUserLoggedIn() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(kUserLogin) ?? false;
  }

  Future<bool> didCompleteOnboarding() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(kOnboarding) ?? false;
  }
}
