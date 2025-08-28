import 'package:flutter_bloc/flutter_bloc.dart';
import 'weather_state.dart';
import 'weather_repository.dart';

class WeatherCubit extends Cubit<WeatherState> {
  final WeatherRepository repository;

  WeatherCubit(this.repository) : super(WeatherInitial());

  Future<void> fetchWeather(String city) async {
    emit(WeatherLoading());
    try {
      final weather = await repository.fetchWeather(city);
      emit(
        WeatherLoaded(
          city: weather.city,
          temperature: weather.temperature,
          description: weather.description,
        ),
      );
    } catch (e) {
      emit(WeatherError('Failed to fetch weather'));
    }
  }
}
