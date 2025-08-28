import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_weather_bloc/main.dart';
import 'package:flutter_weather_bloc/weather_cubit.dart';
import 'package:flutter_weather_bloc/weather_repository.dart';
import 'package:flutter_weather_bloc/weather_model.dart';

class FakeWeatherRepository implements WeatherRepository {
  Weather? weatherToReturn;
  bool throwError = false;

  @override
  Future<Weather> fetchWeather(String city) async {
    if (throwError) throw Exception('error');
    return weatherToReturn ?? Weather(city: city, temperature: 0, description: '');
  }
}

void main() {
  group('Weather App Integration Test', () {
    late FakeWeatherRepository fakeRepository;

    setUp(() {
      fakeRepository = FakeWeatherRepository();
    });

    Widget createTestApp() {
      return MaterialApp(
        home: BlocProvider<WeatherCubit>(
          create: (_) => WeatherCubit(fakeRepository),
          child: WeatherPage(),
        ),
      );
    }

    testWidgets('shows weather data when fetchWeather succeeds', (
      WidgetTester tester,
    ) async {
      fakeRepository.weatherToReturn = Weather(
        city: 'Bangkok',
        temperature: 30.0,
        description: 'Sunny',
      );

      await tester.pumpWidget(createTestApp());
      await tester.enterText(find.byType(TextField), 'Bangkok');
      await tester.tap(find.byType(ElevatedButton));
      await tester.pump(); // Start loading
      expect(find.byType(CircularProgressIndicator), findsOneWidget);
      await tester.pumpAndSettle(); // Wait for async
      expect(find.text('City: Bangkok'), findsOneWidget);
      expect(find.text('Temperature: 30.0°C'), findsOneWidget);
      expect(find.text('Description: Sunny'), findsOneWidget);
    });

    testWidgets('shows error when fetchWeather fails', (WidgetTester tester) async {
      fakeRepository.throwError = true;

      await tester.pumpWidget(createTestApp());
      await tester.enterText(find.byType(TextField), 'Bangkok');
      await tester.tap(find.byType(ElevatedButton));
      await tester.pump(); // Start loading
      expect(find.byType(CircularProgressIndicator), findsOneWidget);
      await tester.pumpAndSettle(); // Wait for async
      expect(find.text('Failed to fetch weather'), findsOneWidget);
    });
  });
}
