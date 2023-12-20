import 'package:wealth_wave/api/apis/goal_api.dart';
import 'package:wealth_wave/api/db/app_database.dart';
import 'package:wealth_wave/core/presenter.dart';

class GoalsPagePresenter extends Presenter<GoalsPageViewState> {
  final GoalApi _goalApi;

  GoalsPagePresenter({
    final GoalApi? goalApi,
  })  : _goalApi = goalApi ?? GoalApi(),
        super(GoalsPageViewState());

  void fetchGoals() {
    _goalApi.getGoals().listen((goals) => updateViewState((viewState) {
          viewState.goals = goals;
        }));
  }

  void deleteGoal({required final int id}) {
    _goalApi.deleteGoal(id: id).then((_) => null);
  }
}

class GoalsPageViewState {
  List<Goal> goals = [];
}
