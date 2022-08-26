import 'package:flutter/material.dart';
import 'package:food_recipe_final/src/providers/settings_manager.dart';
import 'package:provider/provider.dart';

class SettingsBackButton extends StatelessWidget {
  const SettingsBackButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
      final settingsManager =
        Provider.of<SettingsManager>(context, listen: false);
    return IconButton(
      splashRadius: 20,
      onPressed: () {
        Navigator.pop(context);
      },
      icon: Icon(
        Icons.arrow_back,
        color: settingsManager.darkMode ? Colors.white : Colors.black,
        size: 24,
      ),
    );
  }
}
