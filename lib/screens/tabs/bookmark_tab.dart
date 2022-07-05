import 'package:flutter/material.dart';
import 'package:food_recipe_final/components/bookmark_card.dart';
import 'package:food_recipe_final/data/bookmark_manager.dart';
import 'package:food_recipe_final/data/class_models/recipe_model.dart';
import 'package:provider/provider.dart';

class BookmarkTab extends StatefulWidget {
  const BookmarkTab({Key? key}) : super(key: key);

  @override
  State<BookmarkTab> createState() => _BookmarkTabState();
}

class _BookmarkTabState extends State<BookmarkTab>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    return Consumer<BookmarkManager>(builder: (context, manager, child) {
      final recipes = manager.findAllRecipes();
      return ListView.separated(
        key: Key(recipes.length.toString()),
        separatorBuilder: (_, index) => const SizedBox(height: 32),
        itemBuilder: (context, index) {
          return BookmarkCard(
            recipe: recipes[index],
            deleteCallback: () {
              deleteRecipe(manager, recipes[index]);
            },
          );
        },
        itemCount: recipes.length,
      );
    });
  }

  @override
  bool get wantKeepAlive => true;
  void deleteRecipe(BookmarkManager manager, RecipeModel recipe) {
    if (recipe.id != null) {
      manager.deleteRecipe(recipe);
      setState(() {});
    } else {
      print("Recipe ID is null");
    }
  }
}
