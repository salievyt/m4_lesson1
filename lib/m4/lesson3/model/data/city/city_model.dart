

import 'package:equatable/equatable.dart';

import 'package:m4_lesson1/m4/lesson3/model/data/city/city_current_model.dart';

class CityModel extends Equatable {
  final List<CityCurrentModel> current;
  const CityModel({
    required this.current,
  });
  
  @override
  List<Object?> get props => [current];


  factory CityModel.fromJson(Map<String, dynamic> map) {
    return CityModel(
      current: List<CityCurrentModel>.from((map['current'] as List<int>).map<CityCurrentModel>((x) => CityCurrentModel.fromJson(x as Map<String,dynamic>),),),
    );
  }

}
