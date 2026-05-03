import 'package:flutter/material.dart';
import 'package:m4_lesson1/model/service/weather_service.dart';
import 'package:intl/intl.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  String formatUnixTimestamp(int unixTimestamp, String zoneId) {
    // Переводим секунды в миллисекунды и создаем DateTime
    // Обрати внимание: DateTime.fromMillisecondsSinceEpoch по умолчанию
    // работает в UTC или местном времени.
    final date = DateTime.fromMillisecondsSinceEpoch(
      unixTimestamp * 1000,
      isUtc: true,
    );

    // В Dart работа с конкретными zoneId (напр. "Europe/London") через стандартный
    // DateTime ограничена. Обычно используют .toLocal() или .toUtc().
    // Если нужна строгая поддержка ZoneId, используется пакет timezone.

    final formatter = DateFormat("HH' mm'", 'en_US');
    return formatter.format(date);
  }

  @override
  Widget build(BuildContext context) {
    final WeatherAPI api = WeatherAPI();
    api.fethWeather('London');
    return Scaffold(
      body: Column(
        children: [
          SizedBox(
            width: double.infinity,
            child: Image.asset("assets/day.png"),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: FutureBuilder(
              future: api.fethWeather("Bishkek"),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (snapshot.hasError) {
                  return Center(child: Text('Ошибка: ${snapshot.error}'));
                }

                final weather = snapshot.data!;
                int? temp_c = int.tryParse(
                  weather.currentModel.temp_c.toString(),
                );
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(weather.location.localtime),
                        Spacer(),
                        ElevatedButton(
                          onPressed: () {},
                          child: Text(weather.location.name),
                        ),
                      ],
                    ),
                    SizedBox(height: 40),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Spacer(),
                        Column(
                          children: [
                            SizedBox(
                              width: 50,
                              height: 50,
                              child: Image.network(
                                "http:${weather.currentModel.condition.icon}",
                              ),
                            ),
                            Text(
                              weather.currentModel.condition.text,
                              style: TextStyle(fontSize: 18),
                            ),
                          ],
                        ),
                        Spacer(),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${weather.currentModel.temp_c?.toInt()}",
                              style: TextStyle(
                                fontSize: 64,
                                fontWeight: FontWeight.w300,
                              ),
                            ),
                            Text("°C", style: TextStyle(fontSize: 22)),
                          ],
                        ),
                        Spacer(),
                        Column(
                          children: [
                            Row(
                              children: [
                                Text(
                                  "${weather.forecastModel.forecastday[0].day.maxTempC}°C",
                                  style: TextStyle(fontSize: 20),
                                ),
                                SizedBox(width: 2),
                                SizedBox(
                                  width: 6,
                                  child: Image.asset('assets/arrow_up.png'),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Text(
                                  "${weather.forecastModel.forecastday[0].day.minTempC}°C",
                                  style: TextStyle(fontSize: 20),
                                ),
                                SizedBox(width: 2),
                                SizedBox(
                                  width: 6,
                                  child: Image.asset('assets/arrow_down.png'),
                                ),
                              ],
                            ),
                          ],
                        ),
                        Spacer(),
                      ],
                    ),
                    SizedBox(height: 40),
                    WeatherDataWidget(
                      images: [
                        'assets/humidity.png',
                        'assets/barometer.png',
                        'assets/wind.png',
                      ],
                      datas: [
                        '${weather.currentModel.humidity}%',
                        '${weather.currentModel.pressure_mb.toInt()}mBar',
                        '${weather.currentModel.wind_kph.toInt()} km/h',
                      ],
                      titles: ['Humidity', 'Pressure', 'Wind'],
                    ),
                    SizedBox(height: 40),

                    WeatherDataWidget(
                      images: [
                        'assets/sunset.png',
                        'assets/sunrise.png',
                        'assets/sand_time.png',
                      ],
                      datas: [
                        weather.forecastModel.forecastday[0].astroModel.sunset,
                        weather.forecastModel.forecastday[0].astroModel.sunrise,
                        (formatUnixTimestamp(weather.location.localtime_epoch, weather.location.zoneId)),
                      ],
                      titles: ['Sunset', 'Sunrise', 'Daytime'],
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
  List<String> images;
  List<String> datas;
  List<String> titles;
  WeatherDataWidget({
    super.key,
    required this.images,
    required this.datas,
    required this.titles,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Spacer(),
        Column(
          children: [
            SizedBox(width: 40, height: 40, child: Image.asset(images[0])),
            SizedBox(height: 6),
            Text(datas[0], style: TextStyle(fontSize: 22)),

            Text(
              titles[0],
              style: TextStyle(fontSize: 14, color: Color(0xFF999999)),
            ),
          ],
        ),
        Spacer(),
        Column(
          children: [
            SizedBox(width: 40, height: 40, child: Image.asset(images[1])),
            SizedBox(height: 6),
            Text(datas[1], style: TextStyle(fontSize: 22)),

            Text(
              titles[1],
              style: TextStyle(fontSize: 14, color: Color(0xFF999999)),
            ),
          ],
        ),
        Spacer(),
        Column(
          children: [
            SizedBox(width: 40, height: 40, child: Image.asset(images[2])),
            SizedBox(height: 6),
            Text(datas[2], style: TextStyle(fontSize: 22)),

            Text(
              titles[2],
              style: TextStyle(fontSize: 14, color: Color(0xFF999999)),
            ),
          ],
        ),
        Spacer(),
      ],
    );
  }
}
