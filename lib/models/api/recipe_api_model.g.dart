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
        : Fat.fromJson(json['FAT'] as Map<String, dynamic>),
    carbs: json['CHOCDF'] == null
        ? null
        : Carbs.fromJson(json['CHOCDF'] as Map<String, dynamic>),
    fiber: json['FIBTG'] == null
        ? null
        : Fiber.fromJson(json['FIBTG'] as Map<String, dynamic>),
    sugars: json['SUGAR'] == null
        ? null
        : Sugars.fromJson(json['SUGAR'] as Map<String, dynamic>),
    protein: json['PROCNT'] == null
        ? null
        : Protein.fromJson(json['PROCNT'] as Map<String, dynamic>),
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

Fat _$FatFromJson(Map<String, dynamic> json) {
  return Fat(
    label: json['label'] as String,
    quantity: (json['quantity'] as num).toDouble(),
  );
}

Map<String, dynamic> _$FatToJson(Fat instance) => <String, dynamic>{
      'label': instance.label,
      'quantity': instance.quantity,
    };

Carbs _$CarbsFromJson(Map<String, dynamic> json) {
  return Carbs(
    label: json['label'] as String,
    quantity: (json['quantity'] as num).toDouble(),
  );
}

Map<String, dynamic> _$CarbsToJson(Carbs instance) => <String, dynamic>{
      'label': instance.label,
      'quantity': instance.quantity,
    };

Fiber _$FiberFromJson(Map<String, dynamic> json) {
  return Fiber(
    label: json['label'] as String,
    quantity: (json['quantity'] as num).toDouble(),
  );
}

Map<String, dynamic> _$FiberToJson(Fiber instance) => <String, dynamic>{
      'label': instance.label,
      'quantity': instance.quantity,
    };

Sugars _$SugarsFromJson(Map<String, dynamic> json) {
  return Sugars(
    label: json['label'] as String,
    quantity: (json['quantity'] as num).toDouble(),
  );
}

Map<String, dynamic> _$SugarsToJson(Sugars instance) => <String, dynamic>{
      'label': instance.label,
      'quantity': instance.quantity,
    };

Protein _$ProteinFromJson(Map<String, dynamic> json) {
  return Protein(
    label: json['label'] as String,
    quantity: (json['quantity'] as num).toDouble(),
  );
}

Map<String, dynamic> _$ProteinToJson(Protein instance) => <String, dynamic>{
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
