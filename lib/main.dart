import 'package:flutter/material.dart';
import 'package:m4_lesson1/model/data/weather_model.dart';
import 'package:m4_lesson1/view/home_page.dart';

import 'model/service/weather_service.dart';


void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}

class WeatherScreen extends StatelessWidget {
  const WeatherScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final WeatherAPI api = WeatherAPI();

    return Scaffold(
      body: FutureBuilder<WeatherModel>(
        future: api.fethWeather('London'),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Ошибка: ${snapshot.error}'));
          }

          final weather = snapshot.data!;
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Город: ${weather.location.name}'),
                Text('Регион: ${weather.location.region}'),
                Text('Страна: ${weather.location.country}'),
                Text('Широта: ${weather.location.lat}'),
                Text('Долгота: ${weather.location.lon}'),
                Text("data ${weather.currentModel.temp_c}"),
                Text("data ${weather.currentModel.temp_f}"),
                Text("data ${weather.currentModel.is_day}"),
              ],
            ),
          );
        },
      ),
    );
  }
}