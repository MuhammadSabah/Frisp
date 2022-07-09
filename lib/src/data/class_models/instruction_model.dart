import 'package:equatable/equatable.dart';
import 'package:food_recipe_final/src/data/class_models/steps_model.dart';


class InstructionModel extends Equatable {
  List<StepsModel>? steps;
  InstructionModel({
    this.steps,
  });

  @override
  List<Object?> get props => [steps];
}
