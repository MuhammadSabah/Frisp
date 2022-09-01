import 'package:flutter/material.dart';


class SettingsBackButton extends StatelessWidget {
  const SettingsBackButton({Key? key, required this.darkState})
      : super(key: key);
  final darkState;
  @override
  Widget build(BuildContext context) {
    return IconButton(
      splashRadius: 20,
      onPressed: () {
        Navigator.pop(context);
      },
      icon: Icon(
        Icons.arrow_back,
        color: darkState.darkMode ? Colors.white : Colors.black,
        size: 24,
      ),
    );
  }
}
