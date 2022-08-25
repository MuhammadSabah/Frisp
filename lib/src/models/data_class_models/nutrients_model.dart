
import 'package:equatable/equatable.dart';

// ignore: must_be_immutable
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

  NutrientsModel copyWith({
    String? name,
    double? amount,
    String? unit,
  }) {
    return NutrientsModel(
      name: name ?? this.name,
      amount: amount ?? this.amount,
      unit: unit ?? this.unit,
    );
  }

  Map<String, dynamic> toJson() {
    final result = <String, dynamic>{};

    if (name != null) {
      result.addAll({'name': name});
    }
    if (amount != null) {
      result.addAll({'amount': amount});
    }
    if (unit != null) {
      result.addAll({'unit': unit});
    }

    return result;
  }

  factory NutrientsModel.fromJson(Map<String, dynamic> map) {
    return NutrientsModel(
      name: map['name'],
      amount: map['amount']?.toDouble(),
      unit: map['unit'],
    );
  }
}
