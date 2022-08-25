
import 'package:equatable/equatable.dart';

// ignore: must_be_immutable
class StepsModel extends Equatable {
  String? step;

  StepsModel({
    this.step,
  });

  @override
  List<Object?> get props => [step];

  StepsModel copyWith({
    String? step,
  }) {
    return StepsModel(
      step: step ?? this.step,
    );
  }

  Map<String, dynamic> toJson() {
    final result = <String, dynamic>{};

    if (step != null) {
      result.addAll({'step': step});
    }

    return result;
  }

  factory StepsModel.fromJson(Map<String, dynamic> map) {
    return StepsModel(
      step: map['step'],
    );
  }
}
