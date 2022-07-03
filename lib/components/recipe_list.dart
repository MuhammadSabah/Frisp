import 'package:flutter/material.dart';
import 'package:food_recipe_final/components/recipe_card.dart';
import 'package:food_recipe_final/data/class_models/recipe_model.dart';
import 'package:food_recipe_final/models/api/recipe_api_model.dart';
import 'package:food_recipe_final/screens/recipe_detail_screen.dart';

class RecipeList extends StatefulWidget {
  const RecipeList({
    Key? key,
    required this.context,
    required this.results,
  }) : super(key: key);
  final List<ResultsAPI> results;
  final BuildContext context;

  @override
  State<RecipeList> createState() => _RecipeListState();
}

class _RecipeListState extends State<RecipeList> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    double itemWidth = (size.width / 2) - 10;
    double itemHeight = 292;
    return Expanded(
      child: GridView.builder(
        // controller: _scrollController,
        itemCount: widget.results.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: (itemWidth / itemHeight),
        ),
        itemBuilder: (context, index) {
          print(widget.results[index]);
          final result = widget.results[index];
          return _buildRecipeCard(context, widget.results, index);
        },
      ),
    );
  }

  Widget _buildRecipeCard(
      BuildContext context, List<ResultsAPI> results, int index) {
    final recipe = results[index];
    return GestureDetector(
      onTap: () {
        // Navigator.push(context, MaterialPageRoute(
        //   builder: (context) {
        //     final detailRecipe = RecipeModel(
        //       label: recipe.title,
        //       image: recipe.image,
        //       url: recipe.url,
        //       ingredients: convertIngredients(recipe.ingredients),
        //       calories: recipe.calories,
        //       totalWeight: recipe.totalWeight,
        //       totalTime: recipe.totalTime,
        //       cuisine: recipe.cuisine,
        //       meal: recipe.meal,
        //       nutritions: convertNutritions(recipe.nutritions),
        //     );
        //     return RecipeDetailScreen(
        //       recipe: detailRecipe,
        //     );
        //   },
        // ));
      },
      child: RecipeCard(recipe: recipe),
    );
  }
}
