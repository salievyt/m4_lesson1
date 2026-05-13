import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:m4_lesson1/m4/lesson3/view/bottom_dialog.dart';
import 'package:m4_lesson1/m4/lesson3/viewmodel/theme_bloc.dart';
import 'package:m4_lesson1/m4/lesson3/viewmodel/theme_event.dart';
import 'package:m4_lesson1/m4/lesson3/viewmodel/weather_bloc.dart';
import 'package:m4_lesson1/m4/lesson3/viewmodel/weather_event.dart';
import 'package:m4_lesson1/m4/lesson3/viewmodel/weather_state.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String? _selectedLocation = 'Bishkek';

  void _showLocationBottomSheet() {
    showModalBottomSheet<String>(
      context: context,
      builder: (context) => const LocationBottomSheet(),
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
    ).then((selectedLocation) {
      if (selectedLocation != null && selectedLocation.isNotEmpty) {
        setState(() {
          _selectedLocation = selectedLocation;
        });
        context.read<WeatherBloc>().add(LoadWeatherEvent(selectedLocation));
        print('Выбран город: $selectedLocation');
      }
    });
  }

  String formatUnixTimestamp(int unixTimestamp) {
    final date = DateTime.fromMillisecondsSinceEpoch(
      unixTimestamp * 1000,
      isUtc: true,
    );
    final formatter = DateFormat("HH' mm'", 'en_US');
    return formatter.format(date);
  }

  @override
  void initState() {
    super.initState();
    context.read<WeatherBloc>().add(const LoadWeatherEvent('Bishkek'));
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(title: Text(_selectedLocation ?? 'Weather')),
      drawer: Drawer(
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.all(16),
                child: Text(
                  'Настройки темы',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                ),
              ),
              RadioListTile<ThemeMode>(
                title: const Text('Светлая'),
                value: ThemeMode.light,
                groupValue: context.read<ThemeBloc>().state.themeMode,
                onChanged: (value) {
                  if (value != null) {
                    context.read<ThemeBloc>().add(ChangeThemeEvent(value));
                  }
                },
              ),
              RadioListTile<ThemeMode>(
                title: const Text('Темная'),
                value: ThemeMode.dark,
                groupValue: context.read<ThemeBloc>().state.themeMode,
                onChanged: (value) {
                  if (value != null) {
                    context.read<ThemeBloc>().add(ChangeThemeEvent(value));
                  }
                },
              ),
              RadioListTile<ThemeMode>(
                title: const Text('Системная'),
                value: ThemeMode.system,
                groupValue: context.read<ThemeBloc>().state.themeMode,
                onChanged: (value) {
                  if (value != null) {
                    context.read<ThemeBloc>().add(ChangeThemeEvent(value));
                  }
                },
              ),
            ],
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              width: double.infinity,
              child: Image.asset(isDarkMode ? 'assets/night.png' : 'assets/day.png'),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: BlocBuilder<WeatherBloc, WeatherState>(
                builder: (context, state) {
                  if (state is WeatherLoading || state is WeatherInitial) {
                    return const Padding(
                      padding: EdgeInsets.symmetric(vertical: 40),
                      child: CircularProgressIndicator(),
                    );
                  }

                  if (state is WeatherError) {
                    return Center(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 40),
                        child: Text(
                          'Ошибка: ${state.message}',
                          style: const TextStyle(
                            color: Colors.red,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    );
                  }

                  if (state is! WeatherLoaded) {
                    return const SizedBox.shrink();
                  }

                  final weather = state.weather;
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            weather.location.localtime,
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          ElevatedButton.icon(
                            onPressed: _showLocationBottomSheet,
                            icon: const Icon(Icons.location_on),
                            label: Text(weather.location.name),
                            style: ElevatedButton.styleFrom(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 12,
                              ),
                            ),
                          ),
                          const SizedBox(width: 0),
                        ],
                      ),
                      const SizedBox(height: 40),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Spacer(),
                          Column(
                            children: [
                              SizedBox(
                                width: 50,
                                height: 50,
                                child: Image.network(
                                  'http:${weather.currentModel.condition.icon}',
                                  errorBuilder: (context, error, stackTrace) {
                                    return Icon(
                                      Icons.cloud,
                                      size: 50,
                                      color: Colors.grey[400],
                                    );
                                  },
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                weather.currentModel.condition.text,
                                style: const TextStyle(fontSize: 18),
                              ),
                            ],
                          ),
                          const Spacer(),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '${weather.currentModel.temp_c?.toInt()}',
                                style: const TextStyle(
                                  fontSize: 64,
                                  fontWeight: FontWeight.w300,
                                ),
                              ),
                              const Text('°C', style: TextStyle(fontSize: 22)),
                            ],
                          ),
                          const Spacer(),
                          Column(
                            children: [
                              Row(
                                children: [
                                  Text(
                                    '${weather.forecastModel.forecastday[0].day.maxTempC}°C',
                                    style: const TextStyle(fontSize: 20),
                                  ),
                                  const SizedBox(width: 2),
                                  SizedBox(
                                    width: 6,
                                    child: Image.asset('assets/arrow_up.png'),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 4),
                              Row(
                                children: [
                                  Text(
                                    '${weather.forecastModel.forecastday[0].day.minTempC}°C',
                                    style: const TextStyle(fontSize: 20),
                                  ),
                                  const SizedBox(width: 2),
                                  SizedBox(
                                    width: 6,
                                    child: Image.asset('assets/arrow_down.png'),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          const Spacer(),
                        ],
                      ),
                      const SizedBox(height: 40),
                      WeatherDataWidget(
                        images: const [
                          'assets/humidity.png',
                          'assets/barometer.png',
                          'assets/wind.png',
                        ],
                        datas: [
                          '${weather.currentModel.humidity}%',
                          '${weather.currentModel.pressure_mb.toInt()}mBar',
                          '${weather.currentModel.wind_kph.toInt()} km/h',
                        ],
                        titles: const ['Humidity', 'Pressure', 'Wind'],
                      ),
                      const SizedBox(height: 40),
                      WeatherDataWidget(
                        images: const [
                          'assets/sunset.png',
                          'assets/sunrise.png',
                          'assets/sand_time.png',
                        ],
                        datas: [
                          weather.forecastModel.forecastday[0].astroModel.sunset,
                          weather.forecastModel.forecastday[0].astroModel.sunrise,
                          formatUnixTimestamp(weather.location.localtime_epoch),
                        ],
                        titles: const ['Sunset', 'Sunrise', 'Daytime'],
                      ),
                      const SizedBox(height: 40),
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class WeatherDataWidget extends StatelessWidget {
  final List<String> images;
  final List<String> datas;
  final List<String> titles;

  const WeatherDataWidget({
    super.key,
    required this.images,
    required this.datas,
    required this.titles,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Spacer(),
        Column(
          children: [
            SizedBox(width: 40, height: 40, child: Image.asset(images[0])),
            const SizedBox(height: 6),
            Text(datas[0], style: const TextStyle(fontSize: 22)),
            Text(
              titles[0],
              style: const TextStyle(fontSize: 14, color: Color(0xFF999999)),
            ),
          ],
        ),
        const Spacer(),
        Column(
          children: [
            SizedBox(width: 40, height: 40, child: Image.asset(images[1])),
            const SizedBox(height: 6),
            Text(datas[1], style: const TextStyle(fontSize: 22)),
            Text(
              titles[1],
              style: const TextStyle(fontSize: 14, color: Color(0xFF999999)),
            ),
          ],
        ),
        const Spacer(),
        Column(
          children: [
            SizedBox(width: 40, height: 40, child: Image.asset(images[2])),
            const SizedBox(height: 6),
            Text(datas[2], style: const TextStyle(fontSize: 22)),
            Text(
              titles[2],
              style: const TextStyle(fontSize: 14, color: Color(0xFF999999)),
            ),
          ],
        ),
        const Spacer(),
      ],
    );
  }
}
