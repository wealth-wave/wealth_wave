import 'package:wealth_wave/api/apis/goal_api.dart';
import 'package:wealth_wave/domain/models/goal.dart';

class GetGoalsUseCase {
  final GoalApi _goalApi;

  GetGoalsUseCase({final GoalApi? goalApi}) : _goalApi = goalApi ?? GoalApi();

  Future<List<Goal>> getGoals() {
    return _goalApi.getGoals();
  }
}
