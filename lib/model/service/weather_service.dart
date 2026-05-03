import 'package:dio/dio.dart';
import 'package:m4_lesson1/model/data/weather_model.dart';


class WeatherAPI{
  final Dio dio = Dio();

  final api_key = '1e8c3e36e57f4897932142335231802';
  final base_url = 'https://api.weatherapi.com/v1';
  final days = 10;

  Future<WeatherModel> fethWeather(String city) async{
    try{
      final response = await dio.get('$base_url/forecast.json?key=$api_key&q=$city&days=$days');
      final Map<String, dynamic> data = response.data;
      return WeatherModel.fromMap(data);
    } catch (e) {
      print("$e");
      throw Exception("Failed to fetch weather: $e");
    }
  }

}