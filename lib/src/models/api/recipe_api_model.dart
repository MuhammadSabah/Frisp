import 'package:food_recipe_final/src/models/data_class_models/ingredient_model.dart';
import 'package:food_recipe_final/src/models/data_class_models/instruction_model.dart';
import 'package:food_recipe_final/src/models/data_class_models/nutrients_model.dart';
import 'package:food_recipe_final/src/models/data_class_models/nutrition_model.dart';
import 'package:food_recipe_final/src/models/data_class_models/steps_model.dart';
import 'package:json_annotation/json_annotation.dart';
part 'recipe_api_model.g.dart';

@JsonSerializable()
class RecipeAPIQuery {
  List<ResultsAPI> results;

  RecipeAPIQuery({required this.results});
  factory RecipeAPIQuery.fromJson(Map<String, dynamic> json) =>
      _$RecipeAPIQueryFromJson(json);

  Map<String, dynamic> toJson() => _$RecipeAPIQueryToJson(this);
}

@JsonSerializable()
class ResultsAPI {
  int? id;
  bool? vegetarian;
  bool? vegan;
  bool? glutenFree;
  bool? dairyFree;
  bool? veryHealthy;
  bool? cheap;
  bool? veryPopular;
  double? healthScore;
  @JsonKey(name: 'extendedIngredients')
  List<IngredientsAPI>? ingredients;
  String? title;
  int? readyInMinutes;
  int? servings;
  String? sourceUrl;
  String? image;
  NutritionsObjectAPI? nutrition;
  String? summary;
  List<String>? dishTypes;
  List<String>? diets;
  List<String>? occasions;
  @JsonKey(name: 'analyzedInstructions')
  List<InstructionsAPI>? instructions;
  String? spoonacularSourceUrl;
  int? aggregateLikes;
  String? sourceName;

  ResultsAPI({
    this.sourceName,
    this.vegetarian,
    this.vegan,
    this.glutenFree,
    this.dairyFree,
    this.healthScore,
    this.veryHealthy,
    this.cheap,
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
  factory ResultsAPI.fromJson(Map<String, dynamic> json) =>
      _$ResultsAPIFromJson(json);

  Map<String, dynamic> toJson() => _$ResultsAPIToJson(this);
}

@JsonSerializable()
class IngredientsAPI {
  int? id;
  @JsonKey(name: 'original')
  String? name;
  IngredientsAPI({this.id, this.name});

  factory IngredientsAPI.fromJson(Map<String, dynamic> json) =>
      _$IngredientsAPIFromJson(json);

  Map<String, dynamic> toJson() => _$IngredientsAPIToJson(this);
}

@JsonSerializable()
class NutritionsObjectAPI {
  List<NutrientsAPI>? nutrients;
  NutritionsObjectAPI({
    this.nutrients,
  });
  factory NutritionsObjectAPI.fromJson(Map<String, dynamic> json) =>
      _$NutritionsObjectAPIFromJson(json);

  Map<String, dynamic> toJson() => _$NutritionsObjectAPIToJson(this);
}

@JsonSerializable()
class NutrientsAPI {
  String? name;
  double? amount;
  String? unit;

  NutrientsAPI({
    this.name,
    this.amount,
    this.unit,
  });
  factory NutrientsAPI.fromJson(Map<String, dynamic> json) =>
      _$NutrientsAPIFromJson(json);

  Map<String, dynamic> toJson() => _$NutrientsAPIToJson(this);
}

@JsonSerializable()
class InstructionsAPI {
  List<StepsAPI>? steps;
  InstructionsAPI({
    this.steps,
  });
  factory InstructionsAPI.fromJson(Map<String, dynamic> json) =>
      _$InstructionsAPIFromJson(json);

  Map<String, dynamic> toJson() => _$InstructionsAPIToJson(this);
}

@JsonSerializable()
class StepsAPI {
  String? step;

  StepsAPI({this.step});
  factory StepsAPI.fromJson(Map<String, dynamic> json) =>
      _$StepsAPIFromJson(json);

  Map<String, dynamic> toJson() => _$StepsAPIToJson(this);
}

List<IngredientModel> convertIngredients(List<IngredientsAPI> apiIngredients) {
  final ingredients = apiIngredients
      .map((ingredient) => IngredientModel(
            id: ingredient.id,
            name: ingredient.name,
          ))
      .toList();
  return ingredients;
}

List<InstructionModel> convertInstructions(
    List<InstructionsAPI> apiInstructions) {
  final instructions = apiInstructions
      .map((instruction) => InstructionModel(
            steps: convertSteps(instruction.steps!),
          ))
      .toList();
  return instructions;
}

List<StepsModel> convertSteps(List<StepsAPI> apiSteps) {
  final steps = apiSteps
      .map((step) => StepsModel(
            step: step.step,
          ))
      .toList();
  return steps;
}

List<NutrientsModel> convertNutrients(List<NutrientsAPI> apiNutrients) {
  final nutrients = apiNutrients
      .map((nutrient) => NutrientsModel(
            name: nutrient.name,
            amount: nutrient.amount,
            unit: nutrient.unit,
          ))
      .toList();
  return nutrients;
}

NutritionsModel convertNutritions(NutritionsObjectAPI apiNutrition) {
  return NutritionsModel(
      nutrients: convertNutrients(
    apiNutrition.nutrients!,
  ));
}
