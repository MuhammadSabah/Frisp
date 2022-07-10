import 'package:food_recipe_final/src/data/class_models/recipe_model.dart';

abstract class BookmarkInterface {
  Future<List<RecipeModel>> findAllRecipes();
  Future<RecipeModel> findRecipeById(int id);

  Future<void> insertRecipe(RecipeModel recipe);
  Future<void> deleteRecipe(RecipeModel recipe);

  //Streams:
  Stream<List<RecipeModel>> watchAllRecipes();

  Future init();
  void close();
}
