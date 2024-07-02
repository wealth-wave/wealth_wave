import 'package:wealth_wave/domain/models/expense_tag.dart';

class ExpenseTagVO {
  final int id;
  final String name;
  final String description;

  ExpenseTagVO._(
      {required this.id,
      required this.name,
      required this.description});

  factory ExpenseTagVO.from({required final ExpenseTag expenseTag}) {
    return ExpenseTagVO._(
        id: expenseTag.id,
        name: expenseTag.name,
        description: expenseTag.description ?? '');
  }
}
