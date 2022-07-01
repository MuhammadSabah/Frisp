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
  Fat? fat;
  @JsonKey(name: "CHOCDF")
  Carbs? carbs;
  @JsonKey(name: "FIBTG")
  Fiber? fiber;
  @JsonKey(name: "SUGAR")
  Sugars? sugars;
  @JsonKey(name: "PROCNT")
  Protein? protein;

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
class Fat {
  String label;
  double quantity;

  Fat({required this.label, required this.quantity});
  factory Fat.fromJson(Map<String, dynamic> json) => _$FatFromJson(json);

  Map<String, dynamic> toJson() => _$FatToJson(this);
}

@JsonSerializable()
class Carbs {
  String label;
  double quantity;

  Carbs({required this.label, required this.quantity});
  factory Carbs.fromJson(Map<String, dynamic> json) => _$CarbsFromJson(json);

  Map<String, dynamic> toJson() => _$CarbsToJson(this);
}

@JsonSerializable()
class Fiber {
  String label;
  double quantity;

  Fiber({required this.label, required this.quantity});
  factory Fiber.fromJson(Map<String, dynamic> json) => _$FiberFromJson(json);

  Map<String, dynamic> toJson() => _$FiberToJson(this);
}

@JsonSerializable()
class Sugars {
  String label;
  double quantity;

  Sugars({required this.label, required this.quantity});
  factory Sugars.fromJson(Map<String, dynamic> json) => _$SugarsFromJson(json);

  Map<String, dynamic> toJson() => _$SugarsToJson(this);
}

@JsonSerializable()
class Protein {
  String label;
  double quantity;

  Protein({required this.label, required this.quantity});
  factory Protein.fromJson(Map<String, dynamic> json) =>
      _$ProteinFromJson(json);

  Map<String, dynamic> toJson() => _$ProteinToJson(this);
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
