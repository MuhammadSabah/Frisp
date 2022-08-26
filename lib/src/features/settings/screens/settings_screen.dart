import 'package:flutter/material.dart';
import 'package:food_recipe_final/core/app_pages.dart';
import 'package:food_recipe_final/src/providers/app_state_manager.dart';
import 'package:food_recipe_final/src/providers/settings_manager.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:websafe_svg/websafe_svg.dart';

// ignore: must_be_immutable
class SettingsScreen extends StatelessWidget {
  SettingsScreen({Key? key}) : super(key: key);

  bool switchValue = true;
  @override
  Widget build(BuildContext context) {
    final appStateProvider =
        Provider.of<AppStateManager>(context, listen: false);
    final settingsManager =
        Provider.of<SettingsManager>(context, listen: false);
    Color kGreyColorShade =
        settingsManager.darkMode ? Colors.grey.shade300 : Colors.black;
    Color kDividerColor =
        settingsManager.darkMode ? Colors.grey.shade700 : Colors.grey.shade800;
    Color arrowForwardColor =
        settingsManager.darkMode ? Colors.white : Colors.black;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          splashRadius: 20,
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back,
            color: settingsManager.darkMode ? Colors.white : Colors.black,
            size: 24,
          ),
        ),
        centerTitle: true,
        elevation: 0.0,
        bottomOpacity: 0.0,
        title: Text(
          'Settings',
          style: Theme.of(context).textTheme.headline2!.copyWith(fontSize: 18),
        ),
        actions: [
          IconButton(
            splashRadius: 20,
            icon: Icon(
              Icons.more_horiz,
              color: settingsManager.darkMode ? Colors.white : Colors.black,
            ),
            onPressed: () {},
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          children: [
            InkWell(
              onTap: () {
                if (settingsManager.darkMode == true) {
                  settingsManager.setDarkMode(false);
                } else {
                  settingsManager.setDarkMode(true);
                }
              },
              child: Ink(
                height: MediaQuery.of(context).size.height / 14,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Theme',
                      style: Theme.of(context).textTheme.headline3!.copyWith(
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
            ),
            Divider(
              color: kDividerColor,
              thickness: 1.1,
            ),
            InkWell(
              onTap: () {},
              child: Ink(
                height: MediaQuery.of(context).size.height / 14,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Change Password',
                      style: Theme.of(context).textTheme.headline3!.copyWith(
                            color: kGreyColorShade,
                          ),
                    ),
                    Icon(
                      Icons.arrow_forward_ios,
                      color: arrowForwardColor,
                      size: 20,
                    ),
                  ],
                ),
              ),
            ),
            Divider(
              color: kDividerColor,
              thickness: 1.1,
            ),
            InkWell(
              onTap: () {},
              child: Ink(
                height: MediaQuery.of(context).size.height / 14,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Account',
                      style: Theme.of(context)
                          .textTheme
                          .headline3!
                          .copyWith(color: kGreyColorShade),
                    ),
                    Icon(
                      Icons.arrow_forward_ios,
                      color: arrowForwardColor,
                      size: 20,
                    ),
                  ],
                ),
              ),
            ),
            Divider(
              color: kDividerColor,
              thickness: 1.1,
            ),
            InkWell(
              onTap: () {},
              child: Ink(
                height: MediaQuery.of(context).size.height / 14,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Language',
                      style: Theme.of(context)
                          .textTheme
                          .headline3!
                          .copyWith(color: kGreyColorShade),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 6.0),
                      child: Text(
                        'English',
                        style: Theme.of(context)
                            .textTheme
                            .headline3!
                            .copyWith(color: Colors.grey.shade600),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Divider(
              color: kDividerColor,
              thickness: 1.1,
            ),
            InkWell(
              onTap: () {},
              child: Ink(
                height: MediaQuery.of(context).size.height / 13,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Get Help',
                      style: Theme.of(context)
                          .textTheme
                          .headline3!
                          .copyWith(color: kGreyColorShade),
                    ),
                    Icon(
                      Icons.arrow_forward_ios,
                      color: arrowForwardColor,
                      size: 20,
                    ),
                  ],
                ),
              ),
            ),
            Divider(
              color: kDividerColor,
              thickness: 1.1,
            ),
            InkWell(
              onTap: () {},
              child: Ink(
                height: MediaQuery.of(context).size.height / 14,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Report Problem',
                      style: Theme.of(context)
                          .textTheme
                          .headline3!
                          .copyWith(color: kGreyColorShade),
                    ),
                    Icon(
                      Icons.arrow_forward_ios,
                      color: arrowForwardColor,
                      size: 20,
                    ),
                  ],
                ),
              ),
            ),
            Divider(
              color: kDividerColor,
              thickness: 1.1,
            ),
            InkWell(
              onTap: () {},
              child: Ink(
                height: MediaQuery.of(context).size.height / 14,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Terms of Use',
                      style: Theme.of(context)
                          .textTheme
                          .headline3!
                          .copyWith(color: kGreyColorShade),
                    ),
                    Icon(
                      Icons.arrow_forward_ios,
                      color: arrowForwardColor,
                      size: 20,
                    ),
                  ],
                ),
              ),
            ),
            Divider(
              color: kDividerColor,
              thickness: 1.1,
            ),
            InkWell(
              onTap: () async {
                final navigator = Navigator.of(context);
                FocusManager.instance.primaryFocus?.unfocus();
                await appStateProvider.logOutUser();
                navigator.pushNamedAndRemoveUntil(
                    AppPages.loginPath, (route) => false);

                Get.snackbar(
                  '⚠️',
                  'Logged Out',
                  snackPosition: SnackPosition.TOP,
                  forwardAnimationCurve: Curves.elasticInOut,
                  reverseAnimationCurve: Curves.easeOut,
                  colorText:
                      settingsManager.darkMode ? Colors.white : Colors.black,
                );
              },
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
            ),
            Divider(
              color: kDividerColor,
              thickness: 1.1,
            ),
          ],
        ),
      ),
    );
  }
}
