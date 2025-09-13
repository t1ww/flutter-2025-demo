import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'viewmodel/expense_viewmodel.dart';
import 'screen/expense_screen.dart';
import 'screen/add_transaction_screen.dart';
import 'screen/summary_screen.dart';

void main() {
  runApp(const MainApp());
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
              appBar: AppBar(title: const Text('Expense Tracker')),
              body: ChangeNotifierProvider(
                create: (_) => ExpenseViewModel(),
                child: const ExpenseScreen(),
              ),
            ),
        '/add': (context) => const AddTransactionScreen(),
        // Example: '/summary': (context) => SummaryScreen(month: DateTime.now()),
      },
      initialRoute: '/',
    );
  }
}

// ...existing code...
