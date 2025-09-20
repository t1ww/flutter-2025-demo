import 'package:flutter/material.dart';

class Weather {
  final Widget icon;
  final String city;
  final double temperature;
  final String description;
  final double humidity;
  final double windSpeed;

  Weather({
    required this.icon,
    required this.city,
    required this.temperature,
    required this.description,
    required this.humidity,
    required this.windSpeed,
  });
}
