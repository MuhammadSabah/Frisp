import 'package:flutter/material.dart';
import 'package:food_recipe_final/src/providers/settings_provider.dart';
import 'package:provider/provider.dart';
import 'package:websafe_svg/websafe_svg.dart';

class SettingsThemeButton extends StatelessWidget {
  const SettingsThemeButton(
      {Key? key, required this.onTap, required this.kGreyColorShade})
      : super(key: key);
  final Function()? onTap;
  final Color kGreyColorShade;
  @override
  Widget build(BuildContext context) {
    final settingsManager =
        Provider.of<SettingsProvider>(context, listen: false);
    return InkWell(
      onTap: onTap,
      child: Ink(
        height: MediaQuery.of(context).size.height / 14,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Theme',
              style: Theme.of(context).textTheme.displaySmall!.copyWith(
                    color: kGreyColorShade,
                  ),
            ),
            // Switch.adaptive(
            //   value: settingsManager.darkMode,
            //   onChanged: (bool value) {
            //     settingsManager.setDarkMode(value);
            //   },
            // ),
            Padding(
              padding: const EdgeInsets.only(right: 4.0),
              child: AnimatedCrossFade(
                firstChild: WebsafeSvg.asset(
                  'assets/sun.svg',
                  color: Colors.white,
                ),
                secondChild: WebsafeSvg.asset(
                  'assets/moon.svg',
                  color: Colors.black,
                ),
                crossFadeState: settingsManager.darkMode == true
                    ? CrossFadeState.showFirst
                    : CrossFadeState.showSecond,
                duration: const Duration(milliseconds: 450),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
