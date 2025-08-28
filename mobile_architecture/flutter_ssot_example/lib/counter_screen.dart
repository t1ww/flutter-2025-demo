import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'counter_view_model.dart';
import 'counter_repository.dart';

class CounterScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => CounterViewModel(CounterRepository()),
      child: Scaffold(
        appBar: AppBar(title: Text('Single Source of Truth')),
        body: Consumer<CounterViewModel>(
          builder:
              (context, viewModel, _) => Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Counter Value: ${viewModel.counter}'),
                    SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: viewModel.incrementCounter,
                      child: Text('Increment'),
                    ),
                    ElevatedButton(
                      onPressed: viewModel.resetCounter,
                      child: Text('Reset'),
                    ),
                  ],
                ),
              ),
        ),
      ),
    );
  }
}
