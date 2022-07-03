import 'package:equatable/equatable.dart';

class StepsModel extends Equatable {
  String? step;

  StepsModel({this.step});

  @override
  List<Object?> get props => [step];
}
