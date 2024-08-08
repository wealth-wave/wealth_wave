import 'package:wealth_wave/api/db/app_database.dart';

class AggregatedExpense {
  final double amount;
  final List<String> tags;
  final int year;
  final int month;

  AggregatedExpense._({
    required this.amount,
    required this.year,
    required this.month,
    required this.tags,
  });

  factory AggregatedExpense.from({required AggregatedExpenseDO expenseDO}) =>
      AggregatedExpense._(
          amount: expenseDO.amount,
          year: expenseDO.year,
          month: expenseDO.month,
          tags: expenseDO.tags.split(','));
}
