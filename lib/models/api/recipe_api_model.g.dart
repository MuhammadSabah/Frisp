// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'recipe_api_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RecipeAPIQuery _$RecipeAPIQueryFromJson(Map<String, dynamic> json) {
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

Map<String, dynamic> _$RecipeAPIQueryToJson(RecipeAPIQuery instance) =>
    <String, dynamic>{
      'q': instance.query,
      'from': instance.from,
      'to': instance.to,
      'more': instance.more,
      'count': instance.count,
      'hits': instance.hits,
    };

NutritionsAPI _$NutritionsAPIFromJson(Map<String, dynamic> json) {
  return NutritionsAPI(
    fat: json['FAT'] == null
        ? null
        : FatAPI.fromJson(json['FAT'] as Map<String, dynamic>),
    carbs: json['CHOCDF'] == null
        ? null
        : CarbsAPI.fromJson(json['CHOCDF'] as Map<String, dynamic>),
    fiber: json['FIBTG'] == null
        ? null
        : FiberAPI.fromJson(json['FIBTG'] as Map<String, dynamic>),
    sugars: json['SUGAR'] == null
        ? null
        : SugarsAPI.fromJson(json['SUGAR'] as Map<String, dynamic>),
    protein: json['PROCNT'] == null
        ? null
        : ProteinAPI.fromJson(json['PROCNT'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$NutritionsAPIToJson(NutritionsAPI instance) =>
    <String, dynamic>{
      'FAT': instance.fat,
      'CHOCDF': instance.carbs,
      'FIBTG': instance.fiber,
      'SUGAR': instance.sugars,
      'PROCNT': instance.protein,
    };

FatAPI _$FatAPIFromJson(Map<String, dynamic> json) {
  return FatAPI(
    label: json['label'] as String,
    quantity: (json['quantity'] as num).toDouble(),
  );
}

Map<String, dynamic> _$FatAPIToJson(FatAPI instance) => <String, dynamic>{
      'label': instance.label,
      'quantity': instance.quantity,
    };

CarbsAPI _$CarbsAPIFromJson(Map<String, dynamic> json) {
  return CarbsAPI(
    label: json['label'] as String,
    quantity: (json['quantity'] as num).toDouble(),
  );
}

Map<String, dynamic> _$CarbsAPIToJson(CarbsAPI instance) => <String, dynamic>{
      'label': instance.label,
      'quantity': instance.quantity,
    };

FiberAPI _$FiberAPIFromJson(Map<String, dynamic> json) {
  return FiberAPI(
    label: json['label'] as String,
    quantity: (json['quantity'] as num).toDouble(),
  );
}

Map<String, dynamic> _$FiberAPIToJson(FiberAPI instance) => <String, dynamic>{
      'label': instance.label,
      'quantity': instance.quantity,
    };

SugarsAPI _$SugarsAPIFromJson(Map<String, dynamic> json) {
  return SugarsAPI(
    label: json['label'] as String,
    quantity: (json['quantity'] as num).toDouble(),
  );
}

Map<String, dynamic> _$SugarsAPIToJson(SugarsAPI instance) => <String, dynamic>{
      'label': instance.label,
      'quantity': instance.quantity,
    };

ProteinAPI _$ProteinAPIFromJson(Map<String, dynamic> json) {
  return ProteinAPI(
    label: json['label'] as String,
    quantity: (json['quantity'] as num).toDouble(),
  );
}

Map<String, dynamic> _$ProteinAPIToJson(ProteinAPI instance) =>
    <String, dynamic>{
      'label': instance.label,
      'quantity': instance.quantity,
    };

HitsAPI _$HitsAPIFromJson(Map<String, dynamic> json) {
  return HitsAPI(
    recipe: RecipeAPI.fromJson(json['recipe'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$HitsAPIToJson(HitsAPI instance) => <String, dynamic>{
      'recipe': instance.recipe,
    };

RecipeAPI _$RecipeAPIFromJson(Map<String, dynamic> json) {
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
    cuisine:
        (json['cuisineType'] as List<dynamic>).map((e) => e as String).toList(),
    meal: (json['mealType'] as List<dynamic>).map((e) => e as String).toList(),
    nutritions:
        NutritionsAPI.fromJson(json['totalNutrients'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$RecipeAPIToJson(RecipeAPI instance) => <String, dynamic>{
      'label': instance.label,
      'image': instance.image,
      'url': instance.url,
      'ingredients': instance.ingredients,
      'calories': instance.calories,
      'totalWeight': instance.totalWeight,
      'totalTime': instance.totalTime,
      'cuisineType': instance.cuisine,
      'mealType': instance.meal,
      'totalNutrients': instance.nutritions,
    };

IngredientsAPI _$IngredientsAPIFromJson(Map<String, dynamic> json) {
  return IngredientsAPI(
    name: json['text'] as String,
    weight: (json['weight'] as num).toDouble(),
  );
}

Map<String, dynamic> _$IngredientsAPIToJson(IngredientsAPI instance) =>
    <String, dynamic>{
      'text': instance.name,
      'weight': instance.weight,
    };
