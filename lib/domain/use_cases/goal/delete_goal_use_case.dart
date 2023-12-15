import 'package:wealth_wave/api/apis/goal_api.dart';

class DeleteGoalUseCase {
  final GoalApi _goalApi;

  DeleteGoalUseCase({final GoalApi? goalApi}) : _goalApi = goalApi ?? GoalApi();

  Future<void> deleteGoal({required final int id}) {
    return _goalApi.deleteGoal(id: id);
  }
}
