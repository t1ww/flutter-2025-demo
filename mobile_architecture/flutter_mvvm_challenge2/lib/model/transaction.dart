enum TransactionType { income, expense }

class Transaction {
  final String category;
  final double amount;
  final DateTime date;
  final TransactionType type;

  Transaction({
    required this.category,
    required this.amount,
    required this.date,
    required this.type,
  });
}
