import 'package:equatable/equatable.dart';

class IngredientModel extends Equatable {
  int? id;
  int? recipeId;
  final String? name;
  final double? weight;

  IngredientModel({this.id, this.recipeId, this.name, this.weight});

  @override
  List<Object?> get props => [recipeId, name, weight];
}
