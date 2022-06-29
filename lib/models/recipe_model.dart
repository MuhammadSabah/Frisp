import 'package:json_annotation/json_annotation.dart';

part 'recipe_model.g.dart';

@JsonSerializable()
class RecipeQuery {
  factory RecipeQuery.fromJson(Map<String, dynamic> json) =>
      _$RecipeQueryFromJson(json);

  Map<String, dynamic> toJson() => _$RecipeQueryToJson(this);
  @JsonKey(name: 'q')
  String query;
  int from;
  int to;
  bool more;
  int count;
  List<Hits> hits;

  RecipeQuery({
    required this.query,
    required this.from,
    required this.to,
    required this.more,
    required this.count,
    required this.hits,
  });
}

@JsonSerializable()
class Hits {
  Recipe recipe;

  Hits({
    required this.recipe,
  });

  factory Hits.fromJson(Map<String, dynamic> json) => _$HitsFromJson(json);

  Map<String, dynamic> toJson() => _$HitsToJson(this);
}

@JsonSerializable()
class Recipe {
  String label;
  String image;
  String url;
  List<Ingredients> ingredients;
  double calories;
  double totalWeight;
  double totalTime;

  Recipe({
    required this.label,
    required this.image,
    required this.url,
    required this.ingredients,
    required this.calories,
    required this.totalWeight,
    required this.totalTime,
  });

  factory Recipe.fromJson(Map<String, dynamic> json) => _$RecipeFromJson(json);

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
class Ingredients {
  @JsonKey(name: 'text')
  String name;
  double weight;

  Ingredients({
    required this.name,
    required this.weight,
  });

  factory Ingredients.fromJson(Map<String, dynamic> json) =>
      _$IngredientsFromJson(json);

  Map<String, dynamic> toJson() => _$IngredientsToJson(this);
}
