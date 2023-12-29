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
    _goalApi.getGoals().then((goals) => updateViewState((viewState) {
          viewState.goals = goals.map((e) => GoalVO(e, [], 0, 0)).toList();
        }));
  }

  void deleteGoal({required final int id}) {
    _goalApi.deleteGoal(id: id).then((_) => fetchGoals());
  }
}

class GoalsPageViewState {
  List<GoalVO> goals = [];
}

class GoalVO {
  final Goal goal;
  final List<Investment> taggedInvestments;
  final double totalInvestmentValue;
  final double averageGrowthRate;

  GoalVO(this.goal, this.taggedInvestments, this.totalInvestmentValue,
      this.averageGrowthRate);
}
