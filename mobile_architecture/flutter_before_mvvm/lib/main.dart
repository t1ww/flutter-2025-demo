import 'package:flutter/material.dart';

// MOCK: Simulate fetching from API
Future<int> fetchInitialCounter() async {
  await Future.delayed(Duration(seconds: 1));
  return 5;
}

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: CounterPage(),
    );
  }
}

class CounterPage extends StatefulWidget {
  @override
  _CounterPageState createState() => _CounterPageState();
}

class _CounterPageState extends State<CounterPage> {
  int _counter = 0;
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    fetchInitialCounter().then((value) {
      setState(() {
        _counter = value;
        _loading = false;
      });
    });
  }

  void _increment() {
    setState(() {
      _counter++;
    });
  }

  void _decrement() {
    setState(() {
      _counter--;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_loading) return Scaffold(body: Center(child: CircularProgressIndicator()));
    return Scaffold(
      appBar: AppBar(title: Text('Counter App')),
      body: Center(child: Text('Counter: $_counter', style: TextStyle(fontSize: 32))),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(onPressed: _increment, child: Icon(Icons.add)),
          SizedBox(width: 16),
          FloatingActionButton(onPressed: _decrement, child: Icon(Icons.remove)),
        ],
      ),
    );
  }
}
