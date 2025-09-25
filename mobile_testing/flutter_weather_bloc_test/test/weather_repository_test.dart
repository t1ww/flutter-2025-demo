// test/weather_repository_test.dart
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:flutter_weather_bloc/weather_repository.dart';
import 'package:flutter_weather_bloc/weather_model.dart';

import 'weather_repository_test.mocks.dart';

@GenerateMocks([WeatherRepository])
void main() {
  late MockWeatherRepository mockRepository;

  setUp(() {
    mockRepository = MockWeatherRepository();
  });

  test('fetchWeatherServer returns Weather using mock', () async {
    final city = 'Bangkok';
    final mockWeather = Weather(
      city: city,
      temperature: 30.0,
      description: 'Cloudy',
    );

    // Arrange
    when(
      mockRepository.fetchWeatherServer(city),
    ).thenAnswer((_) async => mockWeather);

    // Act
    final result = await mockRepository.fetchWeatherServer(city);

    // Assert
    expect(result.city, city);
    expect(result.temperature, 30.0);
    expect(result.description, 'Cloudy');
    verify(mockRepository.fetchWeatherServer(city)).called(1);
  });

  test('fetchWeatherServer throws when repository fails', () async {
    final city = 'Bangkok';

    when(
      mockRepository.fetchWeatherServer(city),
    ).thenThrow(Exception('Network error'));

    expect(() => mockRepository.fetchWeatherServer(city), throwsException);
    verify(mockRepository.fetchWeatherServer(city)).called(1);
  });
}
