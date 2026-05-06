import 'package:equatable/equatable.dart';
import 'package:m4_lesson1/m4/lesson3/model/data/weather/current_model.dart';

class DayModel extends Equatable {

  final double maxTempC;
  final double minTempC;
  final double maxWindKph;
  final ConditionModel condition;

  const DayModel({
    required this.maxTempC,
    required this.minTempC,
    required this.maxWindKph,
    required this.condition
  });

  @override
  List<Object?> get props => [maxTempC, minTempC, maxWindKph, condition];


  factory DayModel.fromJson(Map<String, dynamic> json) {
    return DayModel(
      maxTempC: json['maxtemp_c'],
      minTempC: json['mintemp_c'],
      maxWindKph: json['maxwind_kph'],
      condition: ConditionModel.fromJson(json['condition'])
    );
  }

}
