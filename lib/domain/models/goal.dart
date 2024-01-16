import 'package:wealth_wave/api/db/app_database.dart';
import 'package:wealth_wave/contract/goal_importance.dart';

class Goal {
  final int id;
  final String name;
  final String? description;
  final double amount;
  final DateTime amountUpdatedOn;
  final DateTime maturityDate;
  final double inflation;
  final GoalImportance importance;

  Goal(
      {required this.id,
      required this.name,
      required this.description,
      required this.amount,
      required this.maturityDate,
      required this.inflation,
      required this.amountUpdatedOn,
      required this.importance});

  static Goal from({required final GoalDO goalDO}) {
    return Goal(
        id: goalDO.id,
        name: goalDO.name,
        description: goalDO.description,
        amount: goalDO.amount,
        maturityDate: goalDO.maturityDate,
        inflation: goalDO.inflation,
        amountUpdatedOn: goalDO.amountUpdatedOn,
        importance: goalDO.importance);
  }
}
