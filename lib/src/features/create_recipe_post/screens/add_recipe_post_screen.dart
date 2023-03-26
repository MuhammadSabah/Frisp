import 'package:flutter/material.dart';
import 'package:food_recipe_final/core/app_pages.dart';
import 'package:food_recipe_final/core/constants.dart';
import 'package:food_recipe_final/src/providers/settings_provider.dart';
import 'package:provider/provider.dart';

class AddRecipePostScreen extends StatelessWidget {
  const AddRecipePostScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final settingsProvider = Provider.of<SettingsProvider>(context);
    return Scaffold(
      body: SafeArea(
          child: Padding(
        padding:
            const EdgeInsets.symmetric(horizontal: 22.0).copyWith(bottom: 94),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Spacer(),
            const Image(
              image: AssetImage('assets/images/vegetarian_line.png'),
              color: kOrangeColor,
              width: 180,
              height: 180,
            ),
            const SizedBox(height: 28),
            Text(
              'Create your food recipe and share it with the community',
              style:
                  Theme.of(context).textTheme.displayLarge!.copyWith(height: 1.4),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 14),
            Text(
              'Help people to find new ideas and develope their cooking skills.',
              style: Theme.of(context).textTheme.displaySmall!.copyWith(
                    height: 1.4,
                    color: settingsProvider.darkMode
                        ? Colors.grey.shade300
                        : Colors.grey.shade700,
                  ),
              textAlign: TextAlign.center,
            ),
            const Spacer(),
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Material(
                color: settingsProvider.darkMode ? Colors.white : kOrangeColor,
                elevation: 4,
                child: InkWell(
                  onTap: () {
                    Navigator.pushNamed(context, AppPages.createPostRecipePath);
                  },
                  child: Ink(
                    height: 52,
                    width: MediaQuery.of(context).size.width,
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(
                        Radius.circular(10),
                      ),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Create Recipe +',
                          style:
                              Theme.of(context).textTheme.displayMedium!.copyWith(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 16,
                                    color: settingsProvider.darkMode
                                        ? kOrangeColor
                                        : Colors.white,
                                  ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      )),
    );
  }
}
