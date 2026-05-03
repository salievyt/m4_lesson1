import 'package:equatable/equatable.dart';
import 'package:m4_lesson1/model/data/astro_model.dart';
import 'package:m4_lesson1/model/data/day_model.dart';

class ForecastDayModel extends Equatable {
  final String date;
  final DayModel day;
  final AstroModel astroModel;

  const ForecastDayModel({
    required this.date,
    required this.day,
    required this.astroModel,
  });

  @override
  List<Object?> get props => [date, day, astroModel];

  factory ForecastDayModel.fromJson(Map<String, dynamic> json) {
    return ForecastDayModel(
      date: json['date'],
      day: DayModel.fromJson(json['day']),
      astroModel: AstroModel.fromJson(json['astro']),
    );
  }
}
