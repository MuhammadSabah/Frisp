import 'package:flutter/material.dart';
import 'package:food_recipe_final/core/app_pages.dart';
import 'package:food_recipe_final/core/app_theme.dart';
import 'package:food_recipe_final/src/providers/app_state_manager.dart';
import 'package:provider/provider.dart';

Color kGreyColorShade = Colors.grey.shade300;

class SettingsScreen extends StatelessWidget {
  static MaterialPage page() {
    return MaterialPage(
      name: AppPages.settingsPath,
      key: ValueKey(AppPages.settingsPath),
      child: const SettingsScreen(),
    );
  }

  const SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Provider.of<AppStateManager>(context, listen: false)
                .settingsClicked(false);
          },
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.white,
            size: 24,
          ),
        ),
        centerTitle: true,
        elevation: 0.0,
        bottomOpacity: 0.0,
        title: Text(
          'Settings',
          style: Theme.of(context).textTheme.headline2,
        ),
        actions: [
          IconButton(
            splashRadius: 20,
            icon: const Icon(
              Icons.more_horiz,
              color: Colors.white,
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
              color: Colors.grey.shade700,
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
              color: Colors.grey.shade700,
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
              color: Colors.grey.shade700,
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
              color: Colors.grey.shade700,
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
              color: Colors.grey.shade700,
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
              color: Colors.grey.shade700,
              thickness: 1.1,
            ),
            InkWell(
              onTap: () {
                Provider.of<AppStateManager>(context, listen: false)
                    .logOutUser();
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
              color: Colors.grey.shade700,
              thickness: 1.1,
            ),
          ],
        ),
      ),
    );
  }
}
