import 'package:equatable/equatable.dart';

abstract class WeatherEvent extends Equatable {
  const WeatherEvent();

  @override
  List<Object?> get props => [];
}

class LoadWeatherEvent extends WeatherEvent {
  final String city;
  const LoadWeatherEvent(this.city);

  @override
  List<Object?> get props => [city];
}
