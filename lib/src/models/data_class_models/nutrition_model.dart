
import 'package:equatable/equatable.dart';

import 'package:food_recipe_final/src/models/data_class_models/nutrients_model.dart';

// ignore: must_be_immutable
class NutritionsModel extends Equatable {
  List<NutrientsModel>? nutrients;
  NutritionsModel({
    this.nutrients,
  });

  @override
  List<Object?> get props => [nutrients];

  NutritionsModel copyWith({
    List<NutrientsModel>? nutrients,
  }) {
    return NutritionsModel(
      nutrients: nutrients ?? this.nutrients,
    );
  }

  Map<String, dynamic> toJson() {
    final result = <String, dynamic>{};

    if (nutrients != null) {
      result.addAll({'nutrients': nutrients!.map((x) => x.toJson()).toList()});
    }

    return result;
  }

  factory NutritionsModel.fromJson(Map<String, dynamic> map) {
    return NutritionsModel(
      nutrients: map['nutrients'] != null
          ? List<NutrientsModel>.from(
              map['nutrients']?.map((x) => NutrientsModel.fromJson(x)))
          : null,
    );
  }
}
