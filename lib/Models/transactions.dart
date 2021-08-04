
class Transaction {
  final String id;
  final String title;
  final double amount;
  final DateTime date;

  Transaction({
    required this.id,
    required this.title,
    required this.amount,
    required this.date,
  });
  Transaction.fromDb(Map<String, dynamic> parsedJson)
  : id = parsedJson['id'],
  title = parsedJson['title'],
  amount = parsedJson['amount'] as double,
  date = parsedJson['date'] as DateTime;
}
