import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'weather_cubit.dart';
import 'weather_state.dart';
import 'weather_repository.dart';

void main() {
  runApp(MainApp());
}

class MainApp extends StatelessWidget {
  MainApp({super.key});

  final WeatherRepository repository = WeatherRepository();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: BlocProvider(
        create: (_) => WeatherCubit(repository),
        child: WeatherPage(),
      ),
    );
  }
}

class WeatherPage extends StatelessWidget {
  WeatherPage({super.key});
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Weather Cubit Example')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _controller,
              decoration: const InputDecoration(labelText: 'Enter city'),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {
                    final city = _controller.text;
                    if (city.isNotEmpty) {
                      context.read<WeatherCubit>().fetchWeather(city);
                    }
                  },
                  child: const Text('Get Weather'),
                ),
                const SizedBox(width: 12),
                ElevatedButton.icon(
                  onPressed: () {
                    final city = _controller.text;
                    if (city.isNotEmpty) {
                      context.read<WeatherCubit>().fetchWeather(city);
                    }
                  },
                  icon: const Icon(Icons.refresh),
                  label: const Text('Refresh'),
                ),
              ],
            ),
            const SizedBox(height: 32),
            BlocBuilder<WeatherCubit, WeatherState>(
              builder: (context, state) {
                if (state is WeatherInitial) {
                  return const Text('Enter a city to get weather');
                } else if (state is WeatherLoading) {
                  return const CircularProgressIndicator();
                } else if (state is WeatherLoaded) {
                  return Column(
                    children: [
                      state.icon,
                      Text(
                        'City: ${state.city}',
                        style: const TextStyle(fontSize: 20),
                      ),
                      Text(
                        'Temperature: ${state.temperature.toStringAsFixed(1)}°C',
                      ),
                      Text('Description: ${state.description}'),
                      Text('Humidity: ${state.humidity.toStringAsFixed(1)}%'),
                      Text(
                        'Wind Speed: ${state.windSpeed.toStringAsFixed(1)} mph',
                      ),
                    ],
                  );
                } else if (state is WeatherError) {
                  return Text(
                    state.message,
                    style: const TextStyle(color: Colors.red),
                  );
                }
                return const SizedBox.shrink();
              },
            ),
          ],
        ),
      ),
    );
  }
}
