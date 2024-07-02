import 'package:wealth_wave/api/db/app_database.dart';

class ExpenseTag {
  final int id;
  final String name;
  final String? description;

  ExpenseTag._(
      {required this.id,
      required this.name,
      required this.description});

  factory ExpenseTag.from({required final ExpenseTagDO expenseTagDO}) =>
      ExpenseTag._(
          id: expenseTagDO.id,
          name: expenseTagDO.name,
          description: expenseTagDO.description);
}
