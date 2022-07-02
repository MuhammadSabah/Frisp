import 'package:flutter/material.dart';
import 'package:food_recipe_final/components/recipe_card.dart';
import 'package:food_recipe_final/data/class_models/recipe_model.dart';
import 'package:food_recipe_final/models/api/recipe_api_model.dart';
import 'package:food_recipe_final/screens/recipe_detail_screen.dart';

class RecipeList extends StatefulWidget {
  const RecipeList({
    Key? key,
    required this.context,
    required this.hits,
  }) : super(key: key);
  final List<HitsAPI> hits;
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
        itemCount: widget.hits.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: (itemWidth / itemHeight),
        ),
        itemBuilder: (context, index) {
          print(widget.hits[index].recipe);
          final hit = widget.hits[index].recipe;
          return _buildRecipeCard(context, widget.hits, index);
        },
      ),
    );
  }

  Widget _buildRecipeCard(BuildContext context, List<HitsAPI> hits, int index) {
    final recipe = hits[index].recipe;
    return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(
          builder: (context) {
            final detailRecipe = RecipeModel(
              label: recipe.label,
              image: recipe.image,
              url: recipe.url,
              ingredients: convertIngredients(recipe.ingredients),
              calories: recipe.calories,
              totalWeight: recipe.totalWeight,
              totalTime: recipe.totalTime,
              cuisine: recipe.cuisine,
              meal: recipe.meal,
              nutritions: convertNutritions(recipe.nutritions),
            );
            return RecipeDetailScreen(
              recipe: detailRecipe,
            );
          },
        ));
      },
      child: RecipeCard(recipe: recipe),
    );
  }
}
