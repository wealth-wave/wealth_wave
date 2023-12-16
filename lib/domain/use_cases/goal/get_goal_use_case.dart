import 'package:wealth_wave/api/apis/goal_api.dart';
import 'package:wealth_wave/domain/models/goal.dart';

class GetGoalUseCase {
  final GoalApi _goalApi;

  GetGoalUseCase({final GoalApi? goalApi}) : _goalApi = goalApi ?? GoalApi();

  Future<Goal> getGoal({required final int id}) {
    return _goalApi.getGoal(id: id).then((value) => Goal.from(value));
  }
}
