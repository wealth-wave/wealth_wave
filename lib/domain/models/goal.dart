import 'package:wealth_wave/api/db/app_database.dart';
import 'package:wealth_wave/contract/goal_importance.dart';

class Goal {
  final int id;
  final String name;
  final double targetAmount;
  final DateTime targetDate;
  final double inflation;
  final GoalImportance importance;

  Goal(
      {required this.id,
      required this.name,
      required this.targetAmount,
      required this.targetDate,
      required this.inflation,
      required this.importance});

  static Goal from(GoalDTO goal) {
    return Goal(
        id: goal.id,
        name: goal.name,
        targetAmount: goal.targetAmount,
        targetDate: goal.targetDate,
        inflation: goal.inflation,
        importance: goal.importance);
  }
}
