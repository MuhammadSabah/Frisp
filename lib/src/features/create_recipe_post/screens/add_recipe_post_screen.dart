import 'package:flutter/material.dart';
import 'package:food_recipe_final/src/features/create_recipe_post/screens/create_recipe_post_screen.dart';

class AddRecipePostScreen extends StatelessWidget {
  const AddRecipePostScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Center(
        child: ElevatedButton(
          onPressed: () {
            Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const CreateRecipePostScreen(),
                        ),
                      );

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
