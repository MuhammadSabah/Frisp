import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:food_recipe_final/core/app_pages.dart';
import 'package:food_recipe_final/core/constants.dart';

class ProfileMessageButton extends StatelessWidget {
  const ProfileMessageButton({Key? key, required this.userId})
      : super(key: key);
  final String userId;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        Navigator.pushNamed(
          context,
          AppPages.contactsPath,
        );
      },
      splashRadius: 20,
      icon: CircleAvatar(
        backgroundColor: Colors.white.withOpacity(0.9),
        child: const Center(
          child: FaIcon(
            FontAwesomeIcons.solidMessage,
            color: kGreyColor,
            size: 20,
          ),
        ),
      ),
    );
  }
}
