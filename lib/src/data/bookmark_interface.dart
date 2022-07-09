import 'package:food_recipe_final/src/data/class_models/recipe_model.dart';

abstract class BookmarkInterface {
  List<RecipeModel> findAllRecipes();
  RecipeModel findRecipeById(int id);

  void insertRecipe(RecipeModel recipe);

  void deleteRecipe(RecipeModel recipe);

  // Future init();
  // void close();
}
