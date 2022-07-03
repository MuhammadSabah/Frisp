import 'package:equatable/equatable.dart';
import 'package:food_recipe_final/data/class_models/ingredient_model.dart';
import 'package:food_recipe_final/data/class_models/instruction_model.dart';
import 'package:food_recipe_final/data/class_models/nutrition_model.dart';

class RecipeModel extends Equatable {
  int? id;
  bool? vegetarian;
  bool? vegan;
  bool? glutenFree;
  bool? dairyFree;
  bool? veryHealthy;
  bool? healthScore;
  bool? cheap;
  bool? veryPopular;
  List<IngredientModel>? ingredients;
  String? title;
  int? readyInMinutes;
  int? servings;
  String? sourceUrl;
  String? image;
  NutritionsModel? nutrition;
  String? summary;
  List<String>? dishTypes;
  List<String>? diets;
  List<String>? occasions;
  List<InstructionModel>? instructions;
  String? spoonacularSourceUrl;

  RecipeModel({
    this.id,
    this.vegetarian,
    this.vegan,
    this.glutenFree,
    this.dairyFree,
    this.veryHealthy,
    this.cheap,
    this.healthScore,
    this.veryPopular,
    this.ingredients,
    this.title,
    this.readyInMinutes,
    this.servings,
    this.sourceUrl,
    this.image,
    this.nutrition,
    this.summary,
    this.dishTypes,
    this.diets,
    this.occasions,
    this.instructions,
    this.spoonacularSourceUrl,
  });

  @override
  List<Object?> get props => [
        id,
        vegetarian,
        vegan,
        glutenFree,
        dairyFree,
        veryHealthy,
        cheap,
        veryPopular,
        healthScore,
        ingredients,
        title,
        readyInMinutes,
        servings,
        sourceUrl,
        image,
        nutrition,
        summary,
        dishTypes,
        diets,
        occasions,
        instructions,
        spoonacularSourceUrl,
      ];
}