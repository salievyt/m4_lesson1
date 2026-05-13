import 'package:flutter/material.dart';

sealed class ThemeEvent {
  const ThemeEvent();
}

class ChangeThemeEvent extends ThemeEvent {
  final ThemeMode themeMode;

  const ChangeThemeEvent(this.themeMode);
}
