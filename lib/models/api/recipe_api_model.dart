import 'package:food_recipe_final/data/class_models/ingredient_model.dart';
import 'package:food_recipe_final/data/class_models/nutrition_model.dart';
import 'package:food_recipe_final/mock_data/nutritions.dart';
import 'package:json_annotation/json_annotation.dart';

part 'recipe_api_model.g.dart';

@JsonSerializable()
class RecipeAPIQuery {
  factory RecipeAPIQuery.fromJson(Map<String, dynamic> json) =>
      _$RecipeAPIQueryFromJson(json);

  Map<String, dynamic> toJson() => _$RecipeAPIQueryToJson(this);
  @JsonKey(name: 'q')
  String query;
  int from;
  int to;
  bool more;
  int count;
  List<HitsAPI> hits;

  RecipeAPIQuery({
    required this.query,
    required this.from,
    required this.to,
    required this.more,
    required this.count,
    required this.hits,
  });
}

@JsonSerializable()
class NutritionsAPI {
  @JsonKey(name: "FAT")
  FatAPI? fat;
  @JsonKey(name: "CHOCDF")
  CarbsAPI? carbs;
  @JsonKey(name: "FIBTG")
  FiberAPI? fiber;
  @JsonKey(name: "SUGAR")
  SugarsAPI? sugars;
  @JsonKey(name: "PROCNT")
  ProteinAPI? protein;

  NutritionsAPI({
    this.fat,
    this.carbs,
    this.fiber,
    this.sugars,
    this.protein,
  });

  factory NutritionsAPI.fromJson(Map<String, dynamic> json) =>
      _$NutritionsAPIFromJson(json);

  Map<String, dynamic> toJson() => _$NutritionsAPIToJson(this);
}

@JsonSerializable()
class FatAPI {
  String label;
  double quantity;

  FatAPI({required this.label, required this.quantity});
  factory FatAPI.fromJson(Map<String, dynamic> json) => _$FatAPIFromJson(json);

  Map<String, dynamic> toJson() => _$FatAPIToJson(this);
}

@JsonSerializable()
class CarbsAPI {
  String label;
  double quantity;

  CarbsAPI({required this.label, required this.quantity});
  factory CarbsAPI.fromJson(Map<String, dynamic> json) =>
      _$CarbsAPIFromJson(json);

  Map<String, dynamic> toJson() => _$CarbsAPIToJson(this);
}

@JsonSerializable()
class FiberAPI {
  String label;
  double quantity;

  FiberAPI({required this.label, required this.quantity});
  factory FiberAPI.fromJson(Map<String, dynamic> json) =>
      _$FiberAPIFromJson(json);

  Map<String, dynamic> toJson() => _$FiberAPIToJson(this);
}

@JsonSerializable()
class SugarsAPI {
  String label;
  double quantity;

  SugarsAPI({required this.label, required this.quantity});
  factory SugarsAPI.fromJson(Map<String, dynamic> json) =>
      _$SugarsAPIFromJson(json);

  Map<String, dynamic> toJson() => _$SugarsAPIToJson(this);
}

@JsonSerializable()
class ProteinAPI {
  String label;
  double quantity;

  ProteinAPI({required this.label, required this.quantity});
  factory ProteinAPI.fromJson(Map<String, dynamic> json) =>
      _$ProteinAPIFromJson(json);

  Map<String, dynamic> toJson() => _$ProteinAPIToJson(this);
}

@JsonSerializable()
class HitsAPI {
  RecipeAPI recipe;

  HitsAPI({
    required this.recipe,
  });

  factory HitsAPI.fromJson(Map<String, dynamic> json) =>
      _$HitsAPIFromJson(json);

  Map<String, dynamic> toJson() => _$HitsAPIToJson(this);
}

@JsonSerializable()
class RecipeAPI {
  String label;
  String image;
  String url;
  List<IngredientsAPI> ingredients;
  double calories;
  double totalWeight;
  double totalTime;
  @JsonKey(name: 'cuisineType')
  List<String> cuisine;
  @JsonKey(name: 'mealType')
  List<String> meal;
  @JsonKey(name: "totalNutrients")
  NutritionsAPI nutritions;

  RecipeAPI({
    required this.label,
    required this.image,
    required this.url,
    required this.ingredients,
    required this.calories,
    required this.totalWeight,
    required this.totalTime,
    required this.cuisine,
    required this.meal,
    required this.nutritions,
  });

  factory RecipeAPI.fromJson(Map<String, dynamic> json) =>
      _$RecipeAPIFromJson(json);

  Map<String, dynamic> toJson() => _$RecipeAPIToJson(this);
}

String getCalories(double? calories) {
  if (calories == null) {
    return '0 KCAL';
  }
  return '${calories.floor()} KCAL';
}

String getWeight(double? weight) {
  if (weight == null) {
    return '0g';
  }
  return '${weight.floor()}g';
}

@JsonSerializable()
class IngredientsAPI {
  @JsonKey(name: 'text')
  String name;
  double weight;

  IngredientsAPI({
    required this.name,
    required this.weight,
  });

  factory IngredientsAPI.fromJson(Map<String, dynamic> json) =>
      _$IngredientsAPIFromJson(json);

  Map<String, dynamic> toJson() => _$IngredientsAPIToJson(this);
}

List<IngredientModel> convertIngredients(List<IngredientsAPI> apiIngredients) {
  final ingredients = <IngredientModel>[];
  apiIngredients.forEach((ingredient) {
    ingredients
        .add(IngredientModel(name: ingredient.name, weight: ingredient.weight));
  });
  return ingredients;
}

NutritionsModel convertNutritions(NutritionsAPI nutrition) {
  return NutritionsModel(
    fat: Fat(
      label: nutrition.fat!.label,
      quantity: nutrition.fat!.quantity,
    ),
    carbs: Carbs(
      label: nutrition.carbs!.label,
      quantity: nutrition.carbs!.quantity,
    ),
    //
    fiber: Fiber(
      label: nutrition.fiber!.label,
      quantity: nutrition.fiber!.quantity,
    ),
    sugars: Sugars(
      label: nutrition.sugars!.label,
      quantity: nutrition.sugars!.quantity,
    ),
    protein: Protein(
      label: nutrition.protein!.label,
      quantity: nutrition.protein!.quantity,
    ),
  );
}
