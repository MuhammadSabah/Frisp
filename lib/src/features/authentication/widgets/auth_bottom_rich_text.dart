import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:food_recipe_final/src/providers/settings_provider.dart';
import 'package:provider/provider.dart';

class AuthBottomRichText extends StatelessWidget {
  const AuthBottomRichText({
    Key? key,
    required this.onTap,
    required this.detailText,
    required this.clickableText,
    required this.lightColor,
    required this.darkColor,
  }) : super(key: key);
  final Function()? onTap;
  final String detailText;
  final String clickableText;
  final Color lightColor;
  final Color darkColor;
  @override
  Widget build(BuildContext context) {
    final settingsManager =
        Provider.of<SettingsProvider>(context, listen: false);
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        RichText(
          text: TextSpan(
            children: [
              TextSpan(
                text: detailText,
                style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                      color: settingsManager.darkMode ? darkColor : lightColor,
                      fontSize: 14,
                    ),
                recognizer: TapGestureRecognizer()..onTap = onTap,
              ),
              TextSpan(
                text: clickableText,
                style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                recognizer: TapGestureRecognizer()..onTap = onTap,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
