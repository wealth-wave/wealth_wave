import 'package:wealth_wave/api/db/app_database.dart';
import 'package:wealth_wave/core/presenter.dart';
import 'package:wealth_wave/core/single_event.dart';
import 'package:wealth_wave/domain/models/goal.dart';
import 'package:wealth_wave/domain/models/investment.dart';

class TagGoalPresenter extends Presenter<TagGoalViewState> {
  final Investment _investment;

  TagGoalPresenter({required final Investment investment})
      : _investment = investment,
        super(TagGoalViewState());

  void onGoalSelected(int? goalId) {
    updateViewState((viewState) => viewState.goalId = goalId);
  }

  void tagGoal({required final Goal goal}) {
    final double sharePercentage = getViewState().sharePercentage;

    _investment.tagGoal(goal: goal, split: sharePercentage).then((_) =>
        updateViewState(
            (viewState) => viewState.onGoalTagged = SingleEvent(null)));
  }

  void updateTaggedGoal({required final Goal goal}) {
    final double sharePercentage = getViewState().sharePercentage;

    _investment.updateTaggedGoal(goal: goal, split: sharePercentage).then((_) =>
        updateViewState(
            (viewState) => viewState.onGoalTagged = SingleEvent(null)));
  }

  void onPercentageChanged(String text) {
    updateViewState((viewState) =>
        viewState.sharePercentage = double.tryParse(text) ?? 0.0);
  }
}

class TagGoalViewState {
  int? goalId;
  double sharePercentage = 100;
  List<GoalDO> goals = [];
  SingleEvent<void>? onGoalTagged;

  bool isValid() {
    return goalId != null && sharePercentage > 0;
  }
}
