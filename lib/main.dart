import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:m4_lesson1/m4/lesson3/model/service/weather_service.dart';
import 'package:m4_lesson1/m4/lesson3/view/home_page.dart';
import 'package:m4_lesson1/m4/lesson3/viewmodel/weather_bloc.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: BlocProvider(
        create: (_) => WeatherBloc(weatherAPI: WeatherAPI()),
        child: const HomePage(),
      ),
    );
  }
}
