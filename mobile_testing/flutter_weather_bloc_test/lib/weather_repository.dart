import 'weather_model.dart';

class WeatherRepository {
  Future<Weather> fetchWeatherServer(String city) async {
    await Future.delayed(const Duration(seconds: 1));
    // Mock data
    return Weather(city: city, temperature: 25.0 + city.length, description: 'Sunny');
  }
}
