import 'package:equatable/equatable.dart';

import 'package:m4_lesson1/model/data/forecast_day_model.dart';

class ForecastModel extends Equatable {
  final List<ForecastDayModel> forecastday;

  const ForecastModel({required this.forecastday});

  @override
  List<Object?> get props => [forecastday];

  factory ForecastModel.fromJson(Map<String, dynamic> json) {
    return ForecastModel(
      forecastday: List<ForecastDayModel>.from(
        (json['forecastday']).map<ForecastDayModel>(
          (data) => ForecastDayModel.fromJson(data as Map<String, dynamic>),
        ),
      ),
    );
  }
}
