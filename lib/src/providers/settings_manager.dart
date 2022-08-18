import 'package:flutter/cupertino.dart';

class SettingsManager extends ChangeNotifier {
  bool _darkMode = true;
  bool get darkMode => _darkMode;

  void setDarkMode(bool darkMode) {
    _darkMode = darkMode;
    notifyListeners();
  }
}
