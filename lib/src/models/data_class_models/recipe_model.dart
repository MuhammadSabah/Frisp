import 'package:food_recipe_final/src/models/data_class_models/ingredient_model.dart';
import 'package:food_recipe_final/src/models/data_class_models/instruction_model.dart';
import 'package:food_recipe_final/src/models/data_class_models/nutrition_model.dart';

class RecipeModel  {
  int? id;
  bool? vegetarian;
  bool? vegan;
  bool? glutenFree;
  bool? dairyFree;
  bool? veryHealthy;
  double? healthScore;
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
  int? aggregateLikes;
  String? creditsText;

  RecipeModel({
    this.creditsText,
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
    this.aggregateLikes,
  });

 
}
