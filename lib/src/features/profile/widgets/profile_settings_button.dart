import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:food_recipe_final/core/app_pages.dart';
import 'package:food_recipe_final/core/constants.dart';

class ProfileSettingsButton extends StatelessWidget {
  const ProfileSettingsButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      key: const Key('profileSettingsButton'),
      onPressed: () {
         Navigator.pushNamed(
          context,
          AppPages.settingsPath,
        );
     
      },
      splashRadius: 20,
      icon: CircleAvatar(
        backgroundColor: Colors.white.withOpacity(0.9),
        child: const FaIcon(
          FontAwesomeIcons.gear,
          color: kGreyColor,
          size: 20,
        ),
      ),
    );
  }
}
