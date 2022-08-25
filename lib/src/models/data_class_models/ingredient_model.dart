
import 'package:equatable/equatable.dart';

// ignore: must_be_immutable
class IngredientModel extends Equatable {
  int? id;
  String? name;

  IngredientModel({
    this.id,
    this.name,
  });

  @override
  List<Object?> get props => [id, name];

  IngredientModel copyWith({
    int? id,
    String? name,
  }) {
    return IngredientModel(
      id: id ?? this.id,
      name: name ?? this.name,
    );
  }

  Map<String, dynamic> toJson() {
    final result = <String, dynamic>{};

    if (id != null) {
      result.addAll({'id': id});
    }
    if (name != null) {
      result.addAll({'name': name});
    }

    return result;
  }

  factory IngredientModel.fromJson(Map<String, dynamic> map) {
    return IngredientModel(
      id: map['id']?.toInt(),
      name: map['name'],
    );
  }
}
