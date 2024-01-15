import 'package:wealth_wave/api/apis/goal_api.dart';
import 'package:wealth_wave/api/apis/investment_api.dart';
import 'package:wealth_wave/api/db/app_database.dart';
import 'package:wealth_wave/core/presenter.dart';
import 'package:wealth_wave/core/single_event.dart';

class TagGoalPresenter extends Presenter<TagGoalViewState> {
  final GoalApi _goalApi;
  final InvestmentApi _investmentApi;
  final int investmentId;

  TagGoalPresenter(this.investmentId,
      {final InvestmentApi? investmentApi, final GoalApi? goalApi})
      : _investmentApi = investmentApi ?? InvestmentApi(),
        _goalApi = goalApi ?? GoalApi(),
        super(TagGoalViewState(investmentId: investmentId));

  void getGoals() {
    _goalApi.get().then(
        (goals) => updateViewState((viewState) => viewState.goals = goals));
  }

  void onGoalSelected(int? goalId) {
    updateViewState((viewState) => viewState.goalId = goalId);
  }

  void tagGoal({int? idToUpdate}) {
    final int? goalId = getViewState().goalId;
    final double sharePercentage = getViewState().sharePercentage;

    if (goalId == null) {
      return;
    }

    if (idToUpdate != null) {
      _investmentApi
          .updateGoalInvestmentMap(
              id: idToUpdate, goalId: goalId, percentage: sharePercentage)
          .then((_) => updateViewState(
              (viewState) => viewState.onGoalTagged = SingleEvent(null)));
    } else {
      _investmentApi
          .createGoalInvestmentMap(
              investmentId: investmentId,
              goalId: goalId,
              percentage: sharePercentage)
          .then((_) => updateViewState(
              (viewState) => viewState.onGoalTagged = SingleEvent(null)));
    }
  }

  void onPercentageChanged(String text) {
    updateViewState((viewState) =>
        viewState.sharePercentage = double.tryParse(text) ?? 0.0);
  }
}

class TagGoalViewState {
  final int investmentId;
  int? goalId;
  double sharePercentage = 100;
  List<GoalDO> goals = [];
  SingleEvent<void>? onGoalTagged;

  TagGoalViewState({required this.investmentId});

  bool isValid() {
    return goalId != null && sharePercentage > 0;
  }
}
