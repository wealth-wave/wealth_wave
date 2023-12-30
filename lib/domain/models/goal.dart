import 'package:wealth_wave/api/db/app_database.dart';
import 'package:wealth_wave/contract/goal_importance.dart';
import 'package:wealth_wave/domain/models/investment.dart';

class Goal {
  final int id;
  final String name;
  final double amount;
  final DateTime createdDate;
  final double inflation;
  final double targetAmount;
  final DateTime targetDate;
  final GoalImportance importance;
  final Map<Investment, double> taggedInvestments;

  Goal(
      {required this.id,
      required this.name,
      required this.amount,
      required this.createdDate,
      required this.inflation,
      required this.targetAmount,
      required this.targetDate,
      required this.importance,
      required this.taggedInvestments});

  static Goal from(
          {required final GoalDO goal,
          required final Map<Investment, double> taggedInvestments}) =>
      Goal(
          id: goal.id,
          name: goal.name,
          amount: goal.amount,
          createdDate: goal.date,
          inflation: goal.inflation,
          targetAmount: goal.targetAmount,
          targetDate: goal.targetDate,
          importance: goal.importance,
          taggedInvestments: taggedInvestments);
}
