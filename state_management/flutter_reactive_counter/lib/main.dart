import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'counter_model.dart';

void main() {
  runApp(ChangeNotifierProvider(create: (_) => CounterModel(), child: MyApp()));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: CounterScreen());
  }
}

class CounterScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Reactive Counter')),
      body: Consumer<CounterModel>(
        builder: (context, counter, child) {
          return Center(child: Text("Count: ${counter.count}", style: TextStyle(fontSize: 32)));
        },
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(onPressed: () => increment(context), child: Icon(Icons.add)),
          SizedBox(height: 10),
          FloatingActionButton(onPressed: () => reset(context), child: Icon(Icons.refresh)),
        ],
      ),
    );
  }

  void increment(context) {
    final counter = Provider.of<CounterModel>(context, listen: false);
    counter.increment();
  }

  void reset(context) {
    final counter = Provider.of<CounterModel>(context, listen: false);
    counter.reset();
  }
}
