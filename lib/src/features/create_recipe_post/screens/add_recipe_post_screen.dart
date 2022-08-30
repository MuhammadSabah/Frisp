import 'package:flutter/material.dart';
import 'package:food_recipe_final/core/app_pages.dart';
import 'package:food_recipe_final/core/constants.dart';
import 'package:food_recipe_final/src/features/bookmark/widgets/bottom_save_button.dart';

class AddRecipePostScreen extends StatelessWidget {
  const AddRecipePostScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Padding(
        padding:
            const EdgeInsets.symmetric(horizontal: 14.0).copyWith(bottom: 28),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Material(
                color: Colors.white,
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
                              Theme.of(context).textTheme.headline2!.copyWith(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 16,
                                    color: kOrangeColor,
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
