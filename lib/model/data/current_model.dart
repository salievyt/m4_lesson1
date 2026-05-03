import 'package:equatable/equatable.dart';

class CurrentModel extends Equatable {
  final double? temp_c;
  final double? temp_f;
  final int is_day;
  final double pressure_mb;
  final double wind_mph;
  final double wind_kph;
  final int humidity;
  final ConditionModel condition;

  const CurrentModel({
    required this.temp_c,
    required this.temp_f,
    required this.is_day,
    required this.pressure_mb,
    required this.humidity,
    required this.condition,
    required this.wind_mph,
    required this.wind_kph,
  });

  factory CurrentModel.fromJson(Map<String, dynamic> json) {
    return CurrentModel(
      temp_c: json['temp_c'],
      temp_f: json['temp_f'],
      is_day: json['is_day'],
      pressure_mb: json['pressure_mb'],
      humidity: json['humidity'],
      wind_mph: json['wind_mph'],
      wind_kph: json['wind_kph'],
      condition: ConditionModel.fromJson(
        json['condition'] as Map<String, dynamic>,
      ),
    );
  }

  @override
  List<Object?> get props => [temp_c, temp_f, is_day, humidity, pressure_mb, wind_kph, wind_mph];
}

class ConditionModel {
  final String text;
  final String icon;

  ConditionModel({required this.text, required this.icon});

  factory ConditionModel.fromJson(Map<String, dynamic> map) {
    return ConditionModel(
      text: map['text'] as String,
      icon: map['icon'] as String,
    );
  }
}
