// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'recipe_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RecipeQuery _$RecipeQueryFromJson(Map<String, dynamic> json) {
  return RecipeQuery(
    query: json['q'] as String,
    from: json['from'] as int,
    to: json['to'] as int,
    more: json['more'] as bool,
    count: json['count'] as int,
    hits: (json['hits'] as List<dynamic>)
        .map((e) => Hits.fromJson(e as Map<String, dynamic>))
        .toList(),
  );
}

Map<String, dynamic> _$RecipeQueryToJson(RecipeQuery instance) =>
    <String, dynamic>{
      'q': instance.query,
      'from': instance.from,
      'to': instance.to,
      'more': instance.more,
      'count': instance.count,
      'hits': instance.hits,
    };

Hits _$HitsFromJson(Map<String, dynamic> json) {
  return Hits(
    recipe: Recipe.fromJson(json['recipe'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$HitsToJson(Hits instance) => <String, dynamic>{
      'recipe': instance.recipe,
    };

Recipe _$RecipeFromJson(Map<String, dynamic> json) {
  return Recipe(
    label: json['label'] as String,
    image: json['image'] as String,
    url: json['url'] as String,
    ingredients: (json['ingredients'] as List<dynamic>)
        .map((e) => Ingredients.fromJson(e as Map<String, dynamic>))
        .toList(),
    calories: (json['calories'] as num).toDouble(),
    totalWeight: (json['totalWeight'] as num).toDouble(),
    totalTime: (json['totalTime'] as num).toDouble(),
  );
}

Map<String, dynamic> _$RecipeToJson(Recipe instance) => <String, dynamic>{
      'label': instance.label,
      'image': instance.image,
      'url': instance.url,
      'ingredients': instance.ingredients,
      'calories': instance.calories,
      'totalWeight': instance.totalWeight,
      'totalTime': instance.totalTime,
    };

Ingredients _$IngredientsFromJson(Map<String, dynamic> json) {
  return Ingredients(
    name: json['text'] as String,
    weight: (json['weight'] as num).toDouble(),
  );
}

Map<String, dynamic> _$IngredientsToJson(Ingredients instance) =>
    <String, dynamic>{
      'text': instance.name,
      'weight': instance.weight,
    };
