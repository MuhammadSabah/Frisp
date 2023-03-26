import 'package:flutter/material.dart';
import 'package:food_recipe_final/src/providers/settings_provider.dart';
import 'package:test/test.dart';
import 'package:mocktail/mocktail.dart';

class MockChangeNotifier extends Mock implements ChangeNotifier {}

void main() {
  group('SettingsProvider', () {
    late SettingsProvider settingsProvider;
    late ChangeNotifier mockNotifier;

    setUp(() {
      settingsProvider = SettingsProvider();
      mockNotifier = MockChangeNotifier();
    });

    test('initial dark mode is true', () {
      expect(settingsProvider.darkMode, isTrue);
    });

    test('setDarkMode updates dark mode', () {
      settingsProvider.addListener(mockNotifier.notifyListeners);

      settingsProvider.setDarkMode(false);

      verify(() => mockNotifier.notifyListeners()).called(1);
      expect(settingsProvider.darkMode, isFalse);
    });
  });
}
