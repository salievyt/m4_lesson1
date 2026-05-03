import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:m4_lesson1/model/service/weather_service.dart';
import 'package:m4_lesson1/viewmodel/weather_event.dart';
import 'package:m4_lesson1/viewmodel/weather_state.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  final WeatherAPI weatherAPI;

  WeatherBloc({required this.weatherAPI}) : super(const WeatherInitial()) {
    on<LoadWeatherEvent>(_onLoadWeather);
  }

  Future<void> _onLoadWeather(
    LoadWeatherEvent event,
    Emitter<WeatherState> emit,
  ) async {
    emit(const WeatherLoading());
    try {
      final weather = await weatherAPI.fethWeather(event.city);
      emit(WeatherLoaded(weather));
    } catch (e) {
      emit(WeatherError(e.toString()));
    }
  }
}
