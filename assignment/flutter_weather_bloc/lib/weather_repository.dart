import 'dart:math';
import 'weather_model.dart';

class WeatherRepository {
  final Random _random = Random();

  Future<Weather> fetchWeather(String city) async {
    await Future.delayed(const Duration(seconds: 1));

    List<String> possibleDescriptions = [
      'Sunny',
      'Cloudy',
      'Rainy',
      'Stormy',
      'Snowy',
    ];
    String description =
        possibleDescriptions[city.length % possibleDescriptions.length];

    double baseTemp = 20 + city.length.toDouble() % 15;
    double baseHumidity = (50 + (city.length.toDouble() % 20 - 10)).clamp(
      0,
      100,
    );
    double baseWind = (5 + city.length % 10).toDouble();

    double temperature = baseTemp + (_random.nextDouble() - 0.5);
    double humidity = (baseHumidity + (_random.nextDouble() * 4 - 2)).clamp(
      0,
      100,
    );
    double windSpeed = (baseWind + (_random.nextDouble() - 0.5)).clamp(0, 20);

    return Weather(
      city: city,
      temperature: temperature,
      description: description,
      humidity: humidity,
      windSpeed: windSpeed,
    );
  }
}
