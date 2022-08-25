import 'package:flutter/material.dart';
import 'package:food_recipe_final/core/app_pages.dart';

class AddRecipePostScreen extends StatelessWidget {
  const AddRecipePostScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Center(
        child: ElevatedButton(
          onPressed: () {
            Navigator.pushNamed(context, AppPages.createPostRecipePath);
       
          },
          child: const Text(
            'Share your recipe',
            style: TextStyle(
              fontSize: 18,
            ),
          ),
        ),
      )),
    );
  }
}
