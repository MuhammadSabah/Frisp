import 'package:flutter/material.dart';
import 'package:food_recipe_final/core/app_cache.dart';
import 'package:food_recipe_final/src/providers/app_state_manager.dart';
import 'package:food_recipe_final/src/view/widgets/recipe_post_tile.dart';
import 'package:provider/provider.dart';

class ActivityTab extends StatefulWidget {
  const ActivityTab({Key? key}) : super(key: key);

  @override
  State<ActivityTab> createState() => _ActivityTabState();
}

class _ActivityTabState extends State<ActivityTab> {
  @override
  Widget build(BuildContext context) {
    final commentsProvider =
        Provider.of<AppStateManager>(context, listen: false);
    return Expanded(
      child: ListView(
        physics: const BouncingScrollPhysics(),
        children: [
          RecipePostTile(
            onCommentPressed: () {
              commentsProvider.commentsClicked(true);
            },
          ),
        ],
      ),
    );
  }
}
