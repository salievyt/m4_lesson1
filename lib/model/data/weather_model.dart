import 'package:equatable/equatable.dart';

import 'package:m4_lesson1/model/data/current_model.dart';
import 'package:m4_lesson1/model/data/forecast_model.dart';
import 'package:m4_lesson1/model/data/location_model.dart';

class WeatherModel extends Equatable {
  final ForecastModel forecastModel;
  final LocationModel location;
  final CurrentModel currentModel;
  final double? wind_mph;
  final double? wind_kph;

  const WeatherModel({
    required this.forecastModel,
    required this.location,
    required this.currentModel,
    required this.wind_mph,
    required this.wind_kph,
  });

  factory WeatherModel.fromMap(Map<String, dynamic> json) {
    return WeatherModel(
      forecastModel: ForecastModel.fromJson(json['forecast']),
      location: LocationModel.fromJson(json['location']),
      currentModel: CurrentModel.fromJson(json['current']),
      wind_mph: json['wind_mph'],
      wind_kph: json['wind_kph'],
    );
  }

  @override
  List<Object?> get props => [
    location,
    // currentModel,
    wind_kph,
    wind_mph
  ];
}
