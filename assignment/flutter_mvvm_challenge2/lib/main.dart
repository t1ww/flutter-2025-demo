import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'viewmodel/expense_viewmodel.dart';
import 'screen/expense_screen.dart';
import 'screen/add_transaction_screen.dart';
import 'screen/summary_screen.dart';

void main() {
  runApp(
    // Wrap the entire app in a single provider
    ChangeNotifierProvider(
      create: (_) => ExpenseViewModel(),
      child: const MainApp(),
    ),
  );
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Expense Tracker',
      routes: {
        '/':
            (context) => Scaffold(
              appBar: AppBar(title: Text('Expense Tracker')),
              body: ExpenseScreen(), // Uses the shared provider
            ),
        '/add':
            (context) => const AddTransactionScreen(), // Same shared provider
        '/summary':
            (context) => SummaryScreen(month: DateTime.now()), // Optional
      },
      initialRoute: '/',
    );
  }
}
