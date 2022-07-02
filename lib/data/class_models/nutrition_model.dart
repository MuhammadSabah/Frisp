import 'package:equatable/equatable.dart';

class NutritionsModel extends Equatable {
  Fat? fat;
  Carbs? carbs;
  Fiber? fiber;
  Sugars? sugars;
  Protein? protein;

  NutritionsModel({
    this.fat,
    this.carbs,
    this.fiber,
    this.sugars,
    this.protein,
  });

  @override
  List<Object?> get props => [fat, carbs, fiber, sugars, protein];
}

class Fat {
  String label;
  double quantity;

  Fat({required this.label, required this.quantity});
}

class Carbs {
  String label;
  double quantity;

  Carbs({required this.label, required this.quantity});
}

class Fiber {
  String label;
  double quantity;

  Fiber({required this.label, required this.quantity});
}

class Sugars {
  String label;
  double quantity;

  Sugars({required this.label, required this.quantity});
}

class Protein {
  String label;
  double quantity;

  Protein({required this.label, required this.quantity});
}
