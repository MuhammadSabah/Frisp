import 'package:food_recipe_final/data/class_models/ingredient_model.dart';
import 'package:food_recipe_final/data/class_models/recipe_model.dart';

abstract class Bookmark {
  List<RecipeModel> findAllRecipes();
  RecipeModel findRecipeById(int id);

  void insertRecipe(RecipeModel recipe);

  void deleteRecipe(RecipeModel recipe);

  // Future init();
  // void close();
}
