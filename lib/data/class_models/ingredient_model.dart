import 'package:equatable/equatable.dart';

class IngredientModel extends Equatable {
  int? id;
  String? name;

  IngredientModel({this.id, this.name});
  @override
  List<Object?> get props => [id, name];
}
