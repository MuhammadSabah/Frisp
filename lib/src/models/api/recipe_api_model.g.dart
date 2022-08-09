// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'recipe_api_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RecipeAPIQuery _$RecipeAPIQueryFromJson(Map<String, dynamic> json) =>
    RecipeAPIQuery(
      results: (json['results'] as List<dynamic>)
          .map((e) => ResultsAPI.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$RecipeAPIQueryToJson(RecipeAPIQuery instance) =>
    <String, dynamic>{
      'results': instance.results,
    };

ResultsAPI _$ResultsAPIFromJson(Map<String, dynamic> json) => ResultsAPI(
      sourceName: json['sourceName'] as String?,
      vegetarian: json['vegetarian'] as bool?,
      vegan: json['vegan'] as bool?,
      glutenFree: json['glutenFree'] as bool?,
      dairyFree: json['dairyFree'] as bool?,
      healthScore: (json['healthScore'] as num?)?.toDouble(),
      veryHealthy: json['veryHealthy'] as bool?,
      cheap: json['cheap'] as bool?,
      veryPopular: json['veryPopular'] as bool?,
      ingredients: (json['extendedIngredients'] as List<dynamic>?)
          ?.map((e) => IngredientsAPI.fromJson(e as Map<String, dynamic>))
          .toList(),
      title: json['title'] as String?,
      readyInMinutes: json['readyInMinutes'] as int?,
      servings: json['servings'] as int?,
      sourceUrl: json['sourceUrl'] as String?,
      image: json['image'] as String?,
      nutrition: json['nutrition'] == null
          ? null
          : NutritionsObjectAPI.fromJson(
              json['nutrition'] as Map<String, dynamic>),
      summary: json['summary'] as String?,
      dishTypes: (json['dishTypes'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      diets:
          (json['diets'] as List<dynamic>?)?.map((e) => e as String).toList(),
      occasions: (json['occasions'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      instructions: (json['analyzedInstructions'] as List<dynamic>?)
          ?.map((e) => InstructionsAPI.fromJson(e as Map<String, dynamic>))
          .toList(),
      spoonacularSourceUrl: json['spoonacularSourceUrl'] as String?,
      aggregateLikes: json['aggregateLikes'] as int?,
    )..id = json['id'] as int?;

Map<String, dynamic> _$ResultsAPIToJson(ResultsAPI instance) =>
    <String, dynamic>{
      'id': instance.id,
      'vegetarian': instance.vegetarian,
      'vegan': instance.vegan,
      'glutenFree': instance.glutenFree,
      'dairyFree': instance.dairyFree,
      'veryHealthy': instance.veryHealthy,
      'cheap': instance.cheap,
      'veryPopular': instance.veryPopular,
      'healthScore': instance.healthScore,
      'extendedIngredients': instance.ingredients,
      'title': instance.title,
      'readyInMinutes': instance.readyInMinutes,
      'servings': instance.servings,
      'sourceUrl': instance.sourceUrl,
      'image': instance.image,
      'nutrition': instance.nutrition,
      'summary': instance.summary,
      'dishTypes': instance.dishTypes,
      'diets': instance.diets,
      'occasions': instance.occasions,
      'analyzedInstructions': instance.instructions,
      'spoonacularSourceUrl': instance.spoonacularSourceUrl,
      'aggregateLikes': instance.aggregateLikes,
      'sourceName': instance.sourceName,
    };

IngredientsAPI _$IngredientsAPIFromJson(Map<String, dynamic> json) =>
    IngredientsAPI(
      id: json['id'] as int?,
      name: json['original'] as String?,
    );

Map<String, dynamic> _$IngredientsAPIToJson(IngredientsAPI instance) =>
    <String, dynamic>{
      'id': instance.id,
      'original': instance.name,
    };

NutritionsObjectAPI _$NutritionsObjectAPIFromJson(Map<String, dynamic> json) =>
    NutritionsObjectAPI(
      nutrients: (json['nutrients'] as List<dynamic>?)
          ?.map((e) => NutrientsAPI.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$NutritionsObjectAPIToJson(
        NutritionsObjectAPI instance) =>
    <String, dynamic>{
      'nutrients': instance.nutrients,
    };

NutrientsAPI _$NutrientsAPIFromJson(Map<String, dynamic> json) => NutrientsAPI(
      name: json['name'] as String?,
      amount: (json['amount'] as num?)?.toDouble(),
      unit: json['unit'] as String?,
    );

Map<String, dynamic> _$NutrientsAPIToJson(NutrientsAPI instance) =>
    <String, dynamic>{
      'name': instance.name,
      'amount': instance.amount,
      'unit': instance.unit,
    };

InstructionsAPI _$InstructionsAPIFromJson(Map<String, dynamic> json) =>
    InstructionsAPI(
      steps: (json['steps'] as List<dynamic>?)
          ?.map((e) => StepsAPI.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$InstructionsAPIToJson(InstructionsAPI instance) =>
    <String, dynamic>{
      'steps': instance.steps,
    };

StepsAPI _$StepsAPIFromJson(Map<String, dynamic> json) => StepsAPI(
      step: json['step'] as String?,
    );

Map<String, dynamic> _$StepsAPIToJson(StepsAPI instance) => <String, dynamic>{
      'step': instance.step,
    };
