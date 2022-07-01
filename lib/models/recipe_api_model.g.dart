// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'recipe_api_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RecipeAPIQuery _$RecipeQueryFromJson(Map<String, dynamic> json) {
  return RecipeAPIQuery(
    query: json['q'] as String,
    from: json['from'] as int,
    to: json['to'] as int,
    more: json['more'] as bool,
    count: json['count'] as int,
    hits: (json['hits'] as List<dynamic>)
        .map((e) => HitsAPI.fromJson(e as Map<String, dynamic>))
        .toList(),
  );
}

Map<String, dynamic> _$RecipeQueryToJson(RecipeAPIQuery instance) =>
    <String, dynamic>{
      'q': instance.query,
      'from': instance.from,
      'to': instance.to,
      'more': instance.more,
      'count': instance.count,
      'hits': instance.hits,
    };

HitsAPI _$HitsFromJson(Map<String, dynamic> json) {
  return HitsAPI(
    recipe: RecipeAPI.fromJson(json['recipe'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$HitsToJson(HitsAPI instance) => <String, dynamic>{
      'recipe': instance.recipe,
    };

RecipeAPI _$RecipeFromJson(Map<String, dynamic> json) {
  return RecipeAPI(
    label: json['label'] as String,
    image: json['image'] as String,
    url: json['url'] as String,
    ingredients: (json['ingredients'] as List<dynamic>)
        .map((e) => IngredientsAPI.fromJson(e as Map<String, dynamic>))
        .toList(),
    calories: (json['calories'] as num).toDouble(),
    totalWeight: (json['totalWeight'] as num).toDouble(),
    totalTime: (json['totalTime'] as num).toDouble(),
  );
}

Map<String, dynamic> _$RecipeToJson(RecipeAPI instance) => <String, dynamic>{
      'label': instance.label,
      'image': instance.image,
      'url': instance.url,
      'ingredients': instance.ingredients,
      'calories': instance.calories,
      'totalWeight': instance.totalWeight,
      'totalTime': instance.totalTime,
    };

IngredientsAPI _$IngredientsFromJson(Map<String, dynamic> json) {
  return IngredientsAPI(
    name: json['text'] as String,
    weight: (json['weight'] as num).toDouble(),
  );
}

Map<String, dynamic> _$IngredientsToJson(IngredientsAPI instance) =>
    <String, dynamic>{
      'text': instance.name,
      'weight': instance.weight,
    };
