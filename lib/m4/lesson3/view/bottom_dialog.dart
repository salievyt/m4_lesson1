import 'package:flutter/material.dart';
import 'package:m4_lesson1/m4/lesson3/model/service/city_service.dart';

// Модель для города
class City {
  final String id;
  final String name;
  final String country;

  City({
    required this.id,
    required this.name,
    required this.country,
  });

  String get displayName => name;
}

// BottomSheet виджет для выбора городов
class LocationBottomSheet extends StatefulWidget {
  const LocationBottomSheet({Key? key}) : super(key: key);

  @override
  State<LocationBottomSheet> createState() => _LocationBottomSheetState();
}

class _LocationBottomSheetState extends State<LocationBottomSheet> {
  late Future<List<City>> _citiesFuture;
  final _cityAPI = CityAPI();
  String _searchQuery = '';
  City? _selectedCity;
  List<City> _allCities = [];

  @override
  void initState() {
    super.initState();
    _citiesFuture = _fetchAndParseCities();
  }

  Future<List<City>> _fetchAndParseCities() async {
    try {
      final cities = [
        City(id: '1', name: 'Bishkek', country: 'Kyrgyzstan'),
        City(id: '2', name: 'London', country: 'United Kingdom'),
        City(id: '3', name: 'New York', country: 'United States'),
        City(id: '4', name: 'Tokyo', country: 'Japan'),
        City(id: '5', name: 'Paris', country: 'France'),
        City(id: '6', name: 'Moscow', country: 'Russia'),
        City(id: '7', name: 'Beijing', country: 'China'),
        City(id: '8', name: 'Dubai', country: 'United Arab Emirates'),
        City(id: '9', name: 'Sydney', country: 'Australia'),
        City(id: '10', name: 'Singapore', country: 'Singapore'),
        City(id: '11', name: 'Bangkok', country: 'Thailand'),
        City(id: '12', name: 'Hong Kong', country: 'Hong Kong'),
        City(id: '13', name: 'Mumbai', country: 'India'),
        City(id: '14', name: 'Bangkok', country: 'Thailand'),
        City(id: '15', name: 'Istanbul', country: 'Turkey'),
      ];
      _allCities = cities;
      return cities;
    } catch (e) {
      print("Ошибка при загрузке городов: $e");
      rethrow;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Заголовок с индикатором перетаскивания
          Padding(
            padding: const EdgeInsets.only(top: 12, bottom: 20),
            child: Column(
              children: [
                Container(
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ],
            ),
          ),
          // Заголовок "Location"
          const Padding(
            padding: EdgeInsets.only(bottom: 16),
            child: Text(
              'Location',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w500,
                color: Colors.grey,
              ),
            ),
          ),
          // Поле поиска
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: TextField(
              onChanged: (value) {
                setState(() {
                  _searchQuery = value.toLowerCase();
                });
              },
              decoration: InputDecoration(
                hintText: 'Search city...',
                hintStyle: TextStyle(color: Colors.grey[400]),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: Colors.grey[300]!),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: Colors.grey[300]!),
                ),
                filled: true,
                fillColor: Colors.grey[100],
              ),
            ),
          ),
          // Список городов
          Flexible(
            child: FutureBuilder<List<City>>(
              future: _citiesFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Padding(
                    padding: EdgeInsets.all(32),
                    child: CircularProgressIndicator(),
                  );
                }

                if (snapshot.hasError) {
                  return Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          'Error loading cities',
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Colors.red),
                        ),
                        const SizedBox(height: 16),
                        ElevatedButton(
                          onPressed: () {
                            setState(() {
                              _citiesFuture = _fetchAndParseCities();
                            });
                          },
                          child: const Text('Try Again'),
                        ),
                      ],
                    ),
                  );
                }

                final cities = snapshot.data ?? [];

                // Фильтруем города по поисковому запросу
                final filteredCities = cities
                    .where((city) =>
                        city.name.toLowerCase().contains(_searchQuery) ||
                        city.country.toLowerCase().contains(_searchQuery))
                    .toList();

                if (filteredCities.isEmpty) {
                  return Padding(
                    padding: const EdgeInsets.all(32),
                    child: Text(
                      'No cities found',
                      style: TextStyle(
                        color: Colors.grey[600],
                        fontSize: 16,
                      ),
                    ),
                  );
                }

                return ListView.builder(
                  itemCount: filteredCities.length,
                  padding: const EdgeInsets.only(bottom: 16),
                  itemBuilder: (context, index) {
                    final city = filteredCities[index];
                    final isSelected = _selectedCity?.id == city.id;

                    return CityListItem(
                      city: city,
                      isSelected: isSelected,
                      onTap: () {
                        setState(() {
                          _selectedCity = city;
                        });
                        // Закрываем BottomSheet и возвращаем название города
                        Future.delayed(const Duration(milliseconds: 300), () {
                          Navigator.pop(context, city.name);
                        });
                      },
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

// Виджет для элемента списка города
class CityListItem extends StatelessWidget {
  final City city;
  final bool isSelected;
  final VoidCallback onTap;

  const CityListItem({
    Key? key,
    required this.city,
    required this.isSelected,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        child: Container(
          color: isSelected ? Colors.blue[50] : Colors.transparent,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          child: Row(
            children: [
              // Иконка геолокации для выбранного
              if (isSelected)
                const Icon(
                  Icons.location_on,
                  color: Colors.blue,
                  size: 20,
                )
              else
                const SizedBox(width: 20),
              const SizedBox(width: 12),
              // Название города
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      city.name,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      city.country,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: Colors.grey[600],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}