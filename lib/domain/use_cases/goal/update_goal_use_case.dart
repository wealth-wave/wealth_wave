import 'package:wealth_wave/api/apis/goal_api.dart';
import 'package:wealth_wave/contract/goal_importance.dart';

class UpdateGoalUseCase {
  final GoalApi _goalApi;

  UpdateGoalUseCase({final GoalApi? goalApi}) : _goalApi = goalApi ?? GoalApi();

  Future<void> update(
      {required final int id,
      required final String name,
      required final double targetAmount,
      required final DateTime targetDate,
      required final double inflation,
      required final GoalImportance importance}) {
    return _goalApi.update(
        id: id,
        name: name,
        targetAmount: targetAmount,
        targetDate: targetDate,
        inflation: inflation,
        importance: importance);
  }
}
