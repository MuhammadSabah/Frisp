import 'package:food_recipe_final/src/models/data_class_models/recipe_model.dart';

abstract class BookmarkInterface {
  // Methods:
  Future<void> insertRecipe(RecipeModel recipe);
  Future<void> deleteRecipe(RecipeModel recipe);

  //Streams:
  Stream<List<RecipeModel>> watchAllRecipes();

  Future init();
  void close();
}
