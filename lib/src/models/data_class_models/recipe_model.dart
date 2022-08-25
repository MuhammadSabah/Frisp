
import 'package:equatable/equatable.dart';

import 'package:food_recipe_final/src/models/data_class_models/ingredient_model.dart';
import 'package:food_recipe_final/src/models/data_class_models/instruction_model.dart';
import 'package:food_recipe_final/src/models/data_class_models/nutrition_model.dart';

// ignore: must_be_immutable
class RecipeModel extends Equatable {
  int? id;
  bool? vegetarian;
  bool? vegan;
  bool? glutenFree;
  bool? dairyFree;
  bool? veryHealthy;
  double? healthScore;
  bool? cheap;
  bool? veryPopular;
  List<IngredientModel>? ingredients;
  String? title;
  int? readyInMinutes;
  int? servings;
  String? sourceUrl;
  String? image;
  NutritionsModel? nutrition;
  String? summary;
  List<String>? dishTypes;
  List<String>? diets;
  List<String>? occasions;
  List<InstructionModel>? instructions;
  String? spoonacularSourceUrl;
  String? sourceName;
  int? aggregateLikes;
  String? creditsText;

  RecipeModel({
    this.id,
    this.vegetarian,
    this.vegan,
    this.glutenFree,
    this.dairyFree,
    this.veryHealthy,
    this.healthScore,
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
    this.sourceName,
    this.aggregateLikes,
    this.creditsText,
  });
  @override
  List<Object?> get props {
    return [
      id,
      vegetarian,
      vegan,
      glutenFree,
      dairyFree,
      veryHealthy,
      healthScore,
      cheap,
      veryPopular,
      ingredients,
      title,
      readyInMinutes,
      servings,
      sourceUrl,
      image,
      nutrition,
      summary,
      dishTypes,
      diets,
      occasions,
      instructions,
      spoonacularSourceUrl,
      sourceName,
      aggregateLikes,
      creditsText,
    ];
  }

  RecipeModel copyWith({
    int? id,
    bool? vegetarian,
    bool? vegan,
    bool? glutenFree,
    bool? dairyFree,
    bool? veryHealthy,
    double? healthScore,
    bool? cheap,
    bool? veryPopular,
    List<IngredientModel>? ingredients,
    String? title,
    int? readyInMinutes,
    int? servings,
    String? sourceUrl,
    String? image,
    NutritionsModel? nutrition,
    String? summary,
    List<String>? dishTypes,
    List<String>? diets,
    List<String>? occasions,
    List<InstructionModel>? instructions,
    String? spoonacularSourceUrl,
    String? sourceName,
    int? aggregateLikes,
    String? creditsText,
  }) {
    return RecipeModel(
      id: id ?? this.id,
      vegetarian: vegetarian ?? this.vegetarian,
      vegan: vegan ?? this.vegan,
      glutenFree: glutenFree ?? this.glutenFree,
      dairyFree: dairyFree ?? this.dairyFree,
      veryHealthy: veryHealthy ?? this.veryHealthy,
      healthScore: healthScore ?? this.healthScore,
      cheap: cheap ?? this.cheap,
      veryPopular: veryPopular ?? this.veryPopular,
      ingredients: ingredients ?? this.ingredients,
      title: title ?? this.title,
      readyInMinutes: readyInMinutes ?? this.readyInMinutes,
      servings: servings ?? this.servings,
      sourceUrl: sourceUrl ?? this.sourceUrl,
      image: image ?? this.image,
      nutrition: nutrition ?? this.nutrition,
      summary: summary ?? this.summary,
      dishTypes: dishTypes ?? this.dishTypes,
      diets: diets ?? this.diets,
      occasions: occasions ?? this.occasions,
      instructions: instructions ?? this.instructions,
      spoonacularSourceUrl: spoonacularSourceUrl ?? this.spoonacularSourceUrl,
      sourceName: sourceName ?? this.sourceName,
      aggregateLikes: aggregateLikes ?? this.aggregateLikes,
      creditsText: creditsText ?? this.creditsText,
    );
  }

  Map<String, dynamic> toJson() {
    final result = <String, dynamic>{};

    if (id != null) {
      result.addAll({'id': id});
    }
    if (vegetarian != null) {
      result.addAll({'vegetarian': vegetarian});
    }
    if (vegan != null) {
      result.addAll({'vegan': vegan});
    }
    if (glutenFree != null) {
      result.addAll({'glutenFree': glutenFree});
    }
    if (dairyFree != null) {
      result.addAll({'dairyFree': dairyFree});
    }
    if (veryHealthy != null) {
      result.addAll({'veryHealthy': veryHealthy});
    }
    if (healthScore != null) {
      result.addAll({'healthScore': healthScore});
    }
    if (cheap != null) {
      result.addAll({'cheap': cheap});
    }
    if (veryPopular != null) {
      result.addAll({'veryPopular': veryPopular});
    }
    if (ingredients != null) {
      result.addAll(
          {'ingredients': ingredients!.map((x) => x.toJson()).toList()});
    }
    if (title != null) {
      result.addAll({'title': title});
    }
    if (readyInMinutes != null) {
      result.addAll({'readyInMinutes': readyInMinutes});
    }
    if (servings != null) {
      result.addAll({'servings': servings});
    }
    if (sourceUrl != null) {
      result.addAll({'sourceUrl': sourceUrl});
    }
    if (image != null) {
      result.addAll({'image': image});
    }
    if (nutrition != null) {
      result.addAll({'nutrition': nutrition!.toJson()});
    }
    if (summary != null) {
      result.addAll({'summary': summary});
    }
    if (dishTypes != null) {
      result.addAll({'dishTypes': dishTypes});
    }
    if (diets != null) {
      result.addAll({'diets': diets});
    }
    if (occasions != null) {
      result.addAll({'occasions': occasions});
    }
    if (instructions != null) {
      result.addAll(
          {'instructions': instructions!.map((x) => x.toJson()).toList()});
    }
    if (spoonacularSourceUrl != null) {
      result.addAll({'spoonacularSourceUrl': spoonacularSourceUrl});
    }
    if (sourceName != null) {
      result.addAll({'sourceName': sourceName});
    }
    if (aggregateLikes != null) {
      result.addAll({'aggregateLikes': aggregateLikes});
    }
    if (creditsText != null) {
      result.addAll({'creditsText': creditsText});
    }

    return result;
  }

  factory RecipeModel.fromJson(Map<String, dynamic> map) {
    return RecipeModel(
      id: map['id']?.toInt(),
      vegetarian: map['vegetarian'],
      vegan: map['vegan'],
      glutenFree: map['glutenFree'],
      dairyFree: map['dairyFree'],
      veryHealthy: map['veryHealthy'],
      healthScore: map['healthScore']?.toDouble(),
      cheap: map['cheap'],
      veryPopular: map['veryPopular'],
      ingredients: map['ingredients'] != null
          ? List<IngredientModel>.from(
              map['ingredients']?.map((x) => IngredientModel.fromJson(x)))
          : null,
      title: map['title'],
      readyInMinutes: map['readyInMinutes']?.toInt(),
      servings: map['servings']?.toInt(),
      sourceUrl: map['sourceUrl'],
      image: map['image'],
      nutrition: map['nutrition'] != null
          ? NutritionsModel.fromJson(map['nutrition'])
          : null,
      summary: map['summary'],
      dishTypes: List<String>.from(map['dishTypes']),
      diets: List<String>.from(map['diets']),
      occasions: List<String>.from(map['occasions']),
      instructions: map['instructions'] != null
          ? List<InstructionModel>.from(
              map['instructions']?.map((x) => InstructionModel.fromJson(x)))
          : null,
      spoonacularSourceUrl: map['spoonacularSourceUrl'],
      sourceName: map['sourceName'],
      aggregateLikes: map['aggregateLikes']?.toInt(),
      creditsText: map['creditsText'],
    );
  }
}
