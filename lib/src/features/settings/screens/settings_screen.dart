import 'package:flutter/material.dart';
import 'package:food_recipe_final/core/app_pages.dart';
import 'package:food_recipe_final/src/features/settings/widgets/settings_account_detail_button.dart';
import 'package:food_recipe_final/src/features/settings/widgets/settings_back_button.dart';
import 'package:food_recipe_final/src/features/settings/widgets/settings_change_password_button.dart';
import 'package:food_recipe_final/src/features/settings/widgets/settings_log_out_button.dart';
import 'package:food_recipe_final/src/features/settings/widgets/settings_theme_button.dart';
import 'package:food_recipe_final/src/providers/auth_provider.dart';
import 'package:food_recipe_final/src/providers/settings_provider.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class SettingsScreen extends StatelessWidget {
  SettingsScreen({Key? key}) : super(key: key);

  bool switchValue = true;
  @override
  Widget build(BuildContext context) {
    final appStateProvider = Provider.of<AuthProvider>(context, listen: true);
    final settingsManager =
        Provider.of<SettingsProvider>(context, listen: false);
    Color kGreyColorShade =
        settingsManager.darkMode ? Colors.grey.shade300 : Colors.black;
    Color kDividerColor =
        settingsManager.darkMode ? Colors.grey.shade700 : Colors.grey.shade800;
    Color arrowForwardColor =
        settingsManager.darkMode ? Colors.white : Colors.black;

    return Scaffold(
      key: const Key('settingsScreen'),
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        leading: SettingsBackButton(darkState: settingsManager),
        centerTitle: true,
        elevation: 0.0,
        bottomOpacity: 0.0,
        title: Text(
          'Settings',
          style:
              Theme.of(context).textTheme.displayMedium!.copyWith(fontSize: 18),
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
        padding: const EdgeInsets.symmetric(horizontal: 14.0),
        child: Column(
          children: [
            SettingsThemeButton(
              key: const Key('darkModeSwitch'),
              onTap: () {
                if (settingsManager.darkMode == true) {
                  settingsManager.setDarkMode(false);
                } else {
                  settingsManager.setDarkMode(true);
                }
              },
              kGreyColorShade: kGreyColorShade,
            ),
            Divider(
              color: kDividerColor,
              thickness: 1.1,
            ),
            SettingsChangePasswordButton(
                kGreyColorShade: kGreyColorShade,
                arrowForwardColor: arrowForwardColor,
                onTap: () {
                  Navigator.pushNamed(context, AppPages.forgetPasswordPath,
                      arguments: false);
                }),
            Divider(
              color: kDividerColor,
              thickness: 1.1,
            ),
            SettingsAccountDetailsButton(
              kGreyColorShade: kGreyColorShade,
              arrowForwardColor: arrowForwardColor,
              onTap: () {},
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
                          .displaySmall!
                          .copyWith(color: kGreyColorShade),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 6.0),
                      child: Text(
                        'English',
                        style: Theme.of(context)
                            .textTheme
                            .displaySmall!
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
                          .displaySmall!
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
                          .displaySmall!
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
                          .displaySmall!
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
            SettingsLogoutButton(
              kGreyColorShade: kGreyColorShade,
              arrowForwardColor: arrowForwardColor,
              onTap: () {
                final navigator = Navigator.of(context);
                FocusManager.instance.primaryFocus?.unfocus();
                appStateProvider.logOutUser();
                navigator.pushNamedAndRemoveUntil(
                  AppPages.welcomePath,
                  (route) => false,
                );

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
