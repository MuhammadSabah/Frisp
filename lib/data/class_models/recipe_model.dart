import 'package:equatable/equatable.dart';
import 'package:food_recipe_final/data/class_models/ingredient_model.dart';
import 'package:food_recipe_final/data/class_models/nutrition_model.dart';

class RecipeModel extends Equatable {
  int? id;
  final String? label;
  final String? image;
  final String? url;

  List<IngredientModel>? ingredients;
  final double? calories;
  final double? totalWeight;
  final double? totalTime;
  List<String>? cuisine;
  List<String>? meal;
  NutritionsModel? nutritions;

  RecipeModel({
    this.id,
    this.label,
    this.image,
    this.url,
    this.ingredients,
    this.calories,
    this.totalWeight,
    this.totalTime,
    this.cuisine,
    this.meal,
    this.nutritions,
  });

  @override
  List<Object?> get props =>
      [label, image, url, calories, totalWeight, totalTime];
}
