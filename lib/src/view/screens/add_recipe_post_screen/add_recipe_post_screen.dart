import 'package:flutter/material.dart';
import 'package:food_recipe_final/src/view/screens/add_recipe_post_screen/create_recipe_post_screen.dart';

class AddRecipePostScreen extends StatelessWidget {
  const AddRecipePostScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Center(
      child: ElevatedButton(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const CreateRecipePost(),
              ));
        },
        child: const Text(
          'Share your recipe',
          style: TextStyle(
            fontSize: 18,
          ),
        ),
      ),
    ));
  }
}
