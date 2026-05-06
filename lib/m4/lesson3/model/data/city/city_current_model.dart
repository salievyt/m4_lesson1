import 'package:equatable/equatable.dart';

class CityCurrentModel extends Equatable {
  final String name;
  final String country;

  const CityCurrentModel({
    required this.name,
    required this.country,
  });
  
  @override
  List<Object?> get props => [name, country];

  factory CityCurrentModel.fromJson(Map<String, dynamic> json) {
    return CityCurrentModel(
      name: json['name'],
      country: json['country'],
    );
  }

}
