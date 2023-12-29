import 'package:wealth_wave/api/apis/goal_api.dart';
import 'package:wealth_wave/core/presenter.dart';
import 'package:wealth_wave/domain/goal_do.dart';
import 'package:wealth_wave/domain/usecases/fetch_goals_use_case.dart';

class GoalsPagePresenter extends Presenter<GoalsPageViewState> {
  final GoalApi _goalApi;
  final FetchGoalsUseCase _fetchGoalsUseCase;

  GoalsPagePresenter({
    final GoalApi? goalApi,
    final FetchGoalsUseCase? fetchGoalsUseCase,
  })  : _goalApi = goalApi ?? GoalApi(),
        _fetchGoalsUseCase = fetchGoalsUseCase ?? FetchGoalsUseCase(),
        super(GoalsPageViewState());

  void fetchGoals() {
    _fetchGoalsUseCase.invoke().then((goals) => updateViewState((viewState) {
          viewState.goals = goals;
        }));
  }

  void deleteGoal({required final int id}) {
    _goalApi.deleteGoal(id: id).then((_) => fetchGoals());
  }
}

class GoalsPageViewState {
  List<GoalDO> goals = [];
}
