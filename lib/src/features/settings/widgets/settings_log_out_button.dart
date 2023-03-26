import 'package:flutter/material.dart';


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
                          .displaySmall!
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