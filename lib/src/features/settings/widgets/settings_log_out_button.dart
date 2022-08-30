import 'package:flutter/material.dart';
import 'package:food_recipe_final/core/app_pages.dart';
import 'package:food_recipe_final/src/providers/auth_provider.dart';
import 'package:food_recipe_final/src/providers/settings_provider.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';


class SettingsLogoutButton extends StatelessWidget {
  const SettingsLogoutButton({Key? key, required this.kGreyColorShade, required this.arrowForwardColor,required  this.onTap,}) : super(key: key);
  final Color kGreyColorShade;
  final Color arrowForwardColor;
  final Function()? onTap;
  @override
  Widget build(BuildContext context) {
 
    return     InkWell(
              onTap: onTap,
              child: Ink(
                height: MediaQuery.of(context).size.height / 14,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Log out',
                      style: Theme.of(context)
                          .textTheme
                          .headline3!
                          .copyWith(color: kGreyColorShade),
                    ),
                    Icon(
                      Icons.logout,
                      color: arrowForwardColor,
                      size: 20,
                    ),
                  ],
                ),
              ),
            );
  }
}