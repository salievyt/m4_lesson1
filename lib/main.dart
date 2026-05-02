import 'package:flutter/material.dart';
import 'package:m4_lesson1/m4/lesson3/service/user_service.dart';

import 'm4/lesson3/data/user_model.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: WeatherScreen(),
    );
  }
}

class WeatherScreen extends StatelessWidget {
  const WeatherScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final UserApi userApi = UserApi();

    return Scaffold(
      body: FutureBuilder<WeatherModel>(
        future: userApi.fethUsers('London'),
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
              ],
            ),
          );
        },
      ),
    );
  }
}