import 'dart:math';
import 'package:flutter/material.dart';
import 'weather_model.dart';

class WeatherRepository {
  final Random _random = Random();

  Future<Weather> fetchWeather(String city) async {
    await Future.delayed(const Duration(seconds: 1));

    // Base description selection (deterministic by city length)
    List<String> possibleDescriptions = [
      'Sunny',
      'Cloudy',
      'Rainy',
      'Stormy',
      'Snowy',
    ];
    String description =
        possibleDescriptions[city.length % possibleDescriptions.length];

    // Map description to widget icon
    Widget weatherIcon;
    switch (description.toLowerCase()) {
      case 'sunny':
        weatherIcon = const Icon(
          Icons.wb_sunny,
          color: Colors.orange,
          size: 48,
        );
        break;
      case 'cloudy':
        weatherIcon = const Icon(
          Icons.wb_cloudy,
          color: Colors.blueGrey,
          size: 48,
        );
        break;
      case 'rainy':
        weatherIcon = const Icon(Icons.grain, color: Colors.blue, size: 48);
        break;
      case 'stormy':
        weatherIcon = const Icon(
          Icons.flash_on,
          color: Colors.yellow,
          size: 48,
        );
        break;
      case 'snowy':
        weatherIcon = const Icon(
          Icons.ac_unit,
          color: Colors.lightBlueAccent,
          size: 48,
        );
        break;
      default:
        weatherIcon = const Icon(Icons.error, color: Colors.red, size: 48);
    }

    // Deterministic base values
    double baseTemp = 20 + city.length.toDouble() % 15; // 20–34 °C
    double baseHumidity = (50 + (city.length.toDouble() % 20 - 10)).clamp(
      0,
      100,
    ); // ~40–59 %
    double baseWind = (5 + city.length % 10).toDouble(); // 5–14 m/s

    // Tiny random variations (±0.5 for temp, ±2% humidity, ±0.5 wind)
    double temperature = baseTemp + (_random.nextDouble() - 0.5);
    double humidity = (baseHumidity + (_random.nextDouble() * 4 - 2)).clamp(
      0,
      100,
    );
    double windSpeed = (baseWind + (_random.nextDouble() - 0.5)).clamp(0, 20);

    return Weather(
      icon: weatherIcon,
      city: city,
      temperature: temperature,
      description: description,
      humidity: humidity,
      windSpeed: windSpeed,
    );
  }
}
