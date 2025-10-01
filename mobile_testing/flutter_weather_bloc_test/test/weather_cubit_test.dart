import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:flutter_weather_bloc/weather_cubit.dart';
import 'package:flutter_weather_bloc/weather_repository.dart';
import 'package:flutter_weather_bloc/weather_state.dart';
import 'package:flutter_weather_bloc/weather_model.dart';

import 'weather_cubit_test.mocks.dart';

@GenerateMocks([WeatherRepository])
void main() {
  group('WeatherCubit', () {
    late MockWeatherRepository mockRepository;
    late WeatherCubit cubit;

    setUp(() {
      mockRepository = MockWeatherRepository();
      cubit = WeatherCubit(mockRepository);
    });

    tearDown(() {
      cubit.close();
    });

    blocTest<WeatherCubit, WeatherState>(
      'emits [WeatherLoading, WeatherLoaded] when fetchWeather succeeds',
      build: () {
        when(mockRepository.fetchWeatherServer('Bangkok')).thenAnswer(
          (_) async =>
              Weather(city: 'Bangkok', temperature: 30, description: 'Cloudy'),
        );
        return cubit;
      },
      act: (cubit) => cubit.fetchWeather('Bangkok'),
      expect:
          () => [
            WeatherLoading(),
            WeatherLoaded(
              city: 'Bangkok',
              temperature: 30,
              description: 'Cloudy',
            ),
          ],
    );

    blocTest<WeatherCubit, WeatherState>(
      'emits [WeatherLoading, WeatherError] when fetchWeather throws',
      build: () {
        when(
          mockRepository.fetchWeatherServer('Bangkok'),
        ).thenThrow(Exception('error'));
        return cubit;
      },
      act: (cubit) => cubit.fetchWeather('Bangkok'),
      // > isA<Class> // Check if they're certain class
      expect: () => [WeatherLoading(), isA<WeatherError>()],
    );
  });
}
