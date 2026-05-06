import 'package:equatable/equatable.dart';

class LocationModel extends Equatable {
  final String name;
  final String region;
  final String country;
  final double lat;
  final double lon;
  final String localtime;
  final int localtime_epoch;
  final String zoneId;


  const LocationModel({
    required this.name,
    required this.region,
    required this.country,
    required this.lat,
    required this.lon,
    required this.localtime,
    required this.localtime_epoch,
    required this.zoneId,
  });

  factory LocationModel.fromJson(Map<String, dynamic> json) {
    return LocationModel(
      name: json['name'], 
      region: json['region'], 
      country: json['country'], 
      lat: json['lat'], 
      lon: json['lon'],
      localtime_epoch: json['localtime_epoch'],
      localtime: json['localtime'],
      zoneId: json['tz_id'],
      );
  }
  
  @override
  List<Object?> get props => [name, region, country, lat, lon, localtime];
}