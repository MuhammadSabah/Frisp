import 'package:flutter/material.dart';
import 'package:food_recipe_final/components/bookmark_card.dart';
import 'package:food_recipe_final/data/bookmark_manager.dart';
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
      final ingredients = manager.findAllIngredients();
      final recipes = manager.findAllRecipes();
      return ListView.separated(
        separatorBuilder: (_, index) => const SizedBox(height: 18),
        itemBuilder: (context, index) {
          return BookmarkCard(recipe: recipes[index]);
        },
        itemCount: recipes.length,
      );
    });
  }

  @override
  bool get wantKeepAlive => true;
}
