import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:m4_lesson1/viewmodel/weather_bloc.dart';
import 'package:m4_lesson1/viewmodel/weather_event.dart';
import 'package:m4_lesson1/viewmodel/weather_state.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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
    return Scaffold(
      body: Column(
        children: [
          SizedBox(
            width: double.infinity,
            child: Image.asset('assets/day.png'),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: BlocBuilder<WeatherBloc, WeatherState>(
              builder: (context, state) {
                if (state is WeatherLoading || state is WeatherInitial) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (state is WeatherError) {
                  return Center(child: Text('Ошибка: ${state.message}'));
                }

                if (state is! WeatherLoaded) {
                  return const SizedBox.shrink();
                }

                final weather = state.weather;
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(weather.location.localtime),
                        const Spacer(),
                        ElevatedButton(
                          onPressed: () {
                            context.read<WeatherBloc>().add(
                              const LoadWeatherEvent('London'),
                            );
                          },
                          child: Text(weather.location.name),
                        ),
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
                              ),
                            ),
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
                  ],
                );
              },
            ),
          ),
        ],
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
