import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:food_recipe_final/core/constants.dart';

class ProfileBackButton extends StatelessWidget {
  const ProfileBackButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        Navigator.pop(context);
      },
      splashRadius: 20,
      icon: CircleAvatar(
        backgroundColor: Colors.white.withOpacity(0.9),
        child: const FaIcon(
          FontAwesomeIcons.arrowLeft,
          color: kGreyColor,
          size: 20,
        ),
      ),
    );
  }
}
