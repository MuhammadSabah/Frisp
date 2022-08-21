import 'package:flutter/material.dart';
import 'package:food_recipe_final/core/app_pages.dart';
import 'package:food_recipe_final/src/providers/app_state_manager.dart';
import 'package:food_recipe_final/src/providers/settings_manager.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class SettingsScreen extends StatelessWidget {
  SettingsScreen({Key? key}) : super(key: key);
  static MaterialPage page() {
    return MaterialPage(
      name: AppPages.settingsPath,
      key: ValueKey(AppPages.settingsPath),
      child: SettingsScreen(),
    );
  }

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
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          splashRadius: 20,
          onPressed: () {
            Provider.of<AppStateManager>(context, listen: false)
                .settingsClicked(false);
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
              onTap: () {},
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
                    Switch.adaptive(
                      value: settingsManager.darkMode,
                      onChanged: (bool value) {
                        settingsManager.setDarkMode(value);
                      },
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
                    const Icon(
                      Icons.arrow_forward_ios,
                      color: Colors.white,
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
                    const Icon(
                      Icons.arrow_forward_ios,
                      color: Colors.white,
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
                    const Icon(
                      Icons.arrow_forward_ios,
                      color: Colors.white,
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
                    const Icon(
                      Icons.arrow_forward_ios,
                      color: Colors.white,
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
                    const Icon(
                      Icons.arrow_forward_ios,
                      color: Colors.white,
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
              onTap: () {
                FocusManager.instance.primaryFocus?.unfocus();
                appStateProvider.logOutUser();
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
                    const Icon(
                      Icons.logout,
                      color: Colors.white,
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
