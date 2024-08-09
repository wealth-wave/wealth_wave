import 'package:wealth_wave/api/db/app_database.dart';

class AggregatedExpense {
  final double amount;
  final List<String> tags;
  final DateTime month;

  AggregatedExpense._({
    required this.amount,
    required this.month,
    required this.tags,
  });

  factory AggregatedExpense.from({required AggregatedExpenseDO expenseDO}) =>
      AggregatedExpense._(
          amount: expenseDO.amount,
          month: expenseDO.month,
          tags: expenseDO.tags.split(','));
}
