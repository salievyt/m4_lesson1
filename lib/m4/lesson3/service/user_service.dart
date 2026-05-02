import 'package:dio/dio.dart';
import 'package:m4_lesson1/m4/lesson3/data/user_model.dart';

class UserApi{
  final Dio dio = Dio();

  final api_key = '1e8c3e36e57f4897932142335231802';
  final base_url = 'https://api.weatherapi.com/v1';

  Future<WeatherModel> fethUsers(String city) async{
    try{
      final response = await dio.get('$base_url/current.json?key=$api_key&q=$city');
      final Map<String, dynamic> data = response.data;
      return WeatherModel.fromJson(data);
    } catch (e) {
      throw Exception("Error: Failed to fetch users: $e");
    }
  }

}