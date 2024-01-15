import 'package:wealth_wave/api/apis/goal_api.dart';
import 'package:wealth_wave/core/presenter.dart';
import 'package:wealth_wave/domain/models/goal.dart';
import 'package:wealth_wave/domain/usecases/fetch_goals_use_case.dart';

class GoalsPresenter extends Presenter<GoalsViewState> {
  final GoalApi _goalApi;
  final FetchGoalsUseCase _fetchGoalsUseCase;

  GoalsPresenter({
    final GoalApi? goalApi,
    final FetchGoalsUseCase? fetchGoalsUseCase,
  })  : _goalApi = goalApi ?? GoalApi(),
        _fetchGoalsUseCase = fetchGoalsUseCase ?? FetchGoalsUseCase(),
        super(GoalsViewState());

  void fetchGoals() {
    _fetchGoalsUseCase.invoke().then((goals) => updateViewState((viewState) {
          viewState.goals = goals;
        }));
  }

  void deleteGoal({required final int id}) {
    _goalApi.deleteBy(id: id).then((_) => fetchGoals());
  }
}

class GoalsViewState {
  List<Goal> goals = [];
}
