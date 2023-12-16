import 'package:wealth_wave/api/apis/goal_api.dart';
import 'package:wealth_wave/contract/goal_importance.dart';

class CreateGoalUseCase {
  final GoalApi _goalApi;

  CreateGoalUseCase({final GoalApi? goalApi}) : _goalApi = goalApi ?? GoalApi();

  Future<void> createGoal(
      {required final String name,
      required final double amount,
      required final DateTime date,
      required final double inflation,
      required final double targetAmount,
      required final DateTime targetDate,
      required final GoalImportance importance}) {
    return _goalApi.createGoal(
        name: name,
        amount: amount,
        date: date,
        targetAmount: targetAmount,
        targetDate: targetDate,
        inflation: inflation,
        importance: importance);
  }
}
