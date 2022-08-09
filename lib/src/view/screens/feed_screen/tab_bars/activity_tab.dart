import 'package:flutter/material.dart';
import 'package:food_recipe_final/src/view/widgets/recipe_post_tile.dart';

class ActivityTab extends StatefulWidget {
  const ActivityTab({Key? key}) : super(key: key);

  @override
  State<ActivityTab> createState() => _ActivityTabState();
}

class _ActivityTabState extends State<ActivityTab> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      physics: const BouncingScrollPhysics(),
      children: [
        RecipePostTile(),
      ],
    );
  }
}
