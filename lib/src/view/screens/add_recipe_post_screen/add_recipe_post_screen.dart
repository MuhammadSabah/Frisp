import 'package:flutter/material.dart';
import 'package:food_recipe_final/src/providers/app_state_manager.dart';
import 'package:provider/provider.dart';

class AddRecipePostScreen extends StatelessWidget {
  const AddRecipePostScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Center(
      child: ElevatedButton(
        onPressed: () {
          Provider.of<AppStateManager>(context, listen: false)
              .createRecipePostClicked(true);
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
