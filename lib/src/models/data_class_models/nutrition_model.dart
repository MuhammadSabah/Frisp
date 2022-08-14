import 'package:equatable/equatable.dart';
import 'package:food_recipe_final/src/models/data_class_models/nutrients_model.dart';

class NutritionsModel extends Equatable {
  List<NutrientsModel>? nutrients;
  NutritionsModel({
    this.nutrients,
  });
  @override
  List<Object?> get props => [nutrients];
}
