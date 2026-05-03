import 'package:equatable/equatable.dart';

class AstroModel extends Equatable{
  final String sunrise;
  final String sunset;
  final String moonrise;
  final String moonset;
  
  const AstroModel({
    required this.sunrise,
    required this.sunset,
    required this.moonrise,
    required this.moonset,
  });


  factory AstroModel.fromJson(Map<String, dynamic> json) {
    return AstroModel(
      sunrise: json['sunrise'],
      sunset: json['sunset'],
      moonrise: json['moonrise'],
      moonset: json['moonset'],
    );
  }
  
  @override
  List<Object?> get props => [sunrise, sunset, moonrise, moonset];
}
