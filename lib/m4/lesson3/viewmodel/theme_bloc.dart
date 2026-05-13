import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:m4_lesson1/m4/lesson3/viewmodel/theme_event.dart';
import 'package:m4_lesson1/m4/lesson3/viewmodel/theme_state.dart';

class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {
  ThemeBloc() : super(const ThemeState(themeMode: ThemeMode.system)) {
    on<ChangeThemeEvent>((event, emit) {
      emit(state.copyWith(themeMode: event.themeMode));
    });
  }
}
