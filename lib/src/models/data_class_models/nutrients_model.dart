import 'package:equatable/equatable.dart';

class NutrientsModel extends Equatable {
  String? name;
  double? amount;
  String? unit;

  NutrientsModel({
    this.name,
    this.amount,
    this.unit,
  });

  @override
  List<Object?> get props => [name, amount, unit];
}
