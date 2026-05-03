import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:m4_lesson1/viewmodel/weather_event.dart';
import 'package:m4_lesson1/viewmodel/weather_state.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState>{
  WeatherBloc(super.initialState);
}