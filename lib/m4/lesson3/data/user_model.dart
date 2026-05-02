import 'package:equatable/equatable.dart';

class WeatherModel extends Equatable {
  final Location location;

  WeatherModel({
    required this.location,
  });

  factory WeatherModel.fromJson(Map<String, dynamic> json) {
    return WeatherModel(
      location: Location.fromJson(json['location']),
    );
  }
  
  @override
  List<Object?> get props => [location];
}


class Location extends Equatable {
  final String name;
  final String region;
  final String country;
  final double lat;
  final double lon;


  Location({
    required this.name,
    required this.region,
    required this.country,
    required this.lat,
    required this.lon,
  });

  factory Location.fromJson(Map<String, dynamic> json) {
    return Location(
      name: json['name'], 
      region: json['region'], 
      country: json['country'], 
      lat: json['lat'], 
      lon: json['lon']);
  }
  
  @override
  List<Object?> get props => [name, region, country, lat, lon];
}