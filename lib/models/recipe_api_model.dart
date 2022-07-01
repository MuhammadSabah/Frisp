import 'package:json_annotation/json_annotation.dart';

part 'recipe_api_model.g.dart';

@JsonSerializable()
class RecipeAPIQuery {
  factory RecipeAPIQuery.fromJson(Map<String, dynamic> json) =>
      _$RecipeQueryFromJson(json);

  Map<String, dynamic> toJson() => _$RecipeQueryToJson(this);
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
class HitsAPI {
  RecipeAPI recipe;

  HitsAPI({
    required this.recipe,
  });

  factory HitsAPI.fromJson(Map<String, dynamic> json) => _$HitsFromJson(json);

  Map<String, dynamic> toJson() => _$HitsToJson(this);
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

  RecipeAPI({
    required this.label,
    required this.image,
    required this.url,
    required this.ingredients,
    required this.calories,
    required this.totalWeight,
    required this.totalTime,
  });

  factory RecipeAPI.fromJson(Map<String, dynamic> json) =>
      _$RecipeFromJson(json);

  Map<String, dynamic> toJson() => _$RecipeToJson(this);
}

String getCalories(double? calories) {
  if (calories == null) {
    return '0 KCAL';
  }
  return calories.floor().toString() + ' KCAL';
}

String getWeight(double? weight) {
  if (weight == null) {
    return '0g';
  }
  return weight.floor().toString() + 'g';
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
      _$IngredientsFromJson(json);

  Map<String, dynamic> toJson() => _$IngredientsToJson(this);
}
