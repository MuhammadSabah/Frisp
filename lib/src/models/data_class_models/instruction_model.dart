import 'package:equatable/equatable.dart';

import 'package:food_recipe_final/src/models/data_class_models/steps_model.dart';

// ignore: must_be_immutable
class InstructionModel extends Equatable {
  List<StepsModel>? steps;
  InstructionModel({
    this.steps,
  });

  @override
  List<Object?> get props => [steps];

  InstructionModel copyWith({
    List<StepsModel>? steps,
  }) {
    return InstructionModel(
      steps: steps ?? this.steps,
    );
  }

  Map<String, dynamic> toJson() {
    final result = <String, dynamic>{};

    if (steps != null) {
      result.addAll({'steps': steps!.map((x) => x.toJson()).toList()});
    }

    return result;
  }

  factory InstructionModel.fromJson(Map<String, dynamic> map) {
    return InstructionModel(
      steps: map['steps'] != null
          ? List<StepsModel>.from(
              map['steps']?.map((x) => StepsModel.fromJson(x)))
          : null,
    );
  }
}
