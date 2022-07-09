import 'package:flutter/material.dart';
import 'package:food_recipe_final/src/data/bookmark_interface.dart';
import 'package:food_recipe_final/src/data/class_models/ingredient_model.dart';
import 'package:food_recipe_final/src/data/class_models/recipe_model.dart';

class BookmarkManager extends BookmarkInterface with ChangeNotifier {
  final List<RecipeModel> _currentRecipes = [];
  final List<IngredientModel> _currentIngredients = [];

  @override
  List<RecipeModel> findAllRecipes() {
    return _currentRecipes;
  }

  @override
  RecipeModel findRecipeById(int id) {
    return _currentRecipes.firstWhere((recipe) => recipe.id == id);
  }

  @override
  void insertRecipe(RecipeModel recipe) {
    if (!_currentRecipes.contains(recipe)) {
      _currentRecipes.add(recipe);
    }

    notifyListeners();
  }

  @override
  void deleteRecipe(RecipeModel recipe) {
    _currentRecipes.remove(recipe);
  }

  @override
  Future init() {
    return Future.value(null);
  }

  @override
  void close() {}
}
