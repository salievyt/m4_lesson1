import 'package:dio/dio.dart';
import 'package:m4_lesson1/m4/lesson3/model/data/city/city_current_model.dart';
import 'package:m4_lesson1/m4/lesson3/model/data/city/city_model.dart';

class CityAPI {
  final Dio dio = Dio();
  final String api_key = 'zCRj9em2tANIWitI8TMDiJFwdP8xsT5lT36JjDa4';
  final String base_url = 'https://api.api-ninjas.com/v1/city';

  Future<CityModel> fetchCities() async {
    try {
      final response = await dio.get(
        base_url,
        queryParameters: {
          'apiKey': api_key,
        },
      );
      final List<dynamic> citiesJson = response.data;
      return citiesJson.map((x) => CityModel.fromJson(x as Map<String, dynamic>)).first;
    } on DioException catch (e) {
      print("${e.response?.statusCode} : ${e.message}");
      throw Exception("Failed to fetch cities: $e");
    }
  }
}