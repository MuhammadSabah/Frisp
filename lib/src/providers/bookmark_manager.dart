import 'dart:async';
import 'package:food_recipe_final/src/repository/bookmark_interface.dart';
import 'package:food_recipe_final/src/models/data_class_models/recipe_model.dart';

class BookmarkManager extends BookmarkInterface {
  final List<RecipeModel> _currentRecipes = [];

  // Private Streams:
  Stream<List<RecipeModel>>? _recipeStream;

  // Stream Controllers:
  final StreamController _recipeStreamController =
      StreamController<List<RecipeModel>>();

  // Stream Methods:
  @override
  Stream<List<RecipeModel>> watchAllRecipes() {
    _recipeStream ??=
        _recipeStreamController.stream as Stream<List<RecipeModel>>;
    return _recipeStream!;
  }

  //
  @override
  Future<List<RecipeModel>> findAllRecipes() {
    return Future.value(_currentRecipes);
  }

  @override
  Future<RecipeModel> findRecipeById(int id) {
    return Future.value(
        _currentRecipes.firstWhere((recipe) => recipe.id == id));
  }

  @override
  Future<void> insertRecipe(RecipeModel recipe) async {
    if (!_currentRecipes.contains(recipe)) {
      _currentRecipes.add(recipe);
      _recipeStreamController.sink.add(_currentRecipes);
    }
  }

  @override
  Future<void> deleteRecipe(RecipeModel recipe) {
    _currentRecipes.remove(recipe);
    return Future.value();
  }

  @override
  Future init() {
    return Future.value();
  }

  @override
  void close() {
    _recipeStreamController.close();
  }
}
