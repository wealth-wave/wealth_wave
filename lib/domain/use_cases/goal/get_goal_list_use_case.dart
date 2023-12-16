import 'package:wealth_wave/api/apis/goal_api.dart';
import 'package:wealth_wave/domain/models/goal.dart';

class GetGoalListUseCase {
  final GoalApi _goalApi;

  GetGoalListUseCase({final GoalApi? goalApi})
      : _goalApi = goalApi ?? GoalApi();

  Future<List<Goal>> getGoals() {
    return _goalApi
        .getGoals()
        .then((value) => value.map((e) => Goal.from(e)).toList());
  }
}
