import 'package:wealth_wave/api/db/app_database.dart';
import 'package:wealth_wave/core/presenter.dart';
import 'package:wealth_wave/core/single_event.dart';
import 'package:wealth_wave/domain/services/investment_service.dart';

class TagGoalPresenter extends Presenter<TagGoalViewState> {
  final int _investmentId;
  final InvestmentService _investmentService;

  TagGoalPresenter(
      {required final int investmentId,
      final InvestmentService? investmentService})
      : _investmentId = investmentId,
        _investmentService = investmentService ?? InvestmentService(),
        super(TagGoalViewState());

  void onGoalSelected(int? goalId) {
    updateViewState((viewState) => viewState.goalId = goalId);
  }

  void fetchGoals() {}

  void tagGoal() {
    final double sharePercentage = getViewState().sharePercentage;
    final int? goalId = getViewState().goalId;
    if (goalId != null && sharePercentage > 0) {
      _investmentService
          .getBy(id: _investmentId)
          .then((investment) =>
              investment.tagGoal(goalId: goalId, split: sharePercentage))
          .then((_) => updateViewState(
              (viewState) => viewState.onGoalTagged = SingleEvent(null)));
    }
  }

  void updateTaggedGoal({required final int id}) {
    final double sharePercentage = getViewState().sharePercentage;
    final int? goalId = getViewState().goalId;

    if (goalId != null && sharePercentage > 0) {
      _investmentService
          .getBy(id: _investmentId)
          .then((investment) => investment.updateTaggedGoal(
              id: id, goalId: goalId, split: sharePercentage))
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
  int? goalId;
  double sharePercentage = 100;
  List<GoalDO> goals = [];
  SingleEvent<void>? onGoalTagged;

  bool isValid() {
    return goalId != null && sharePercentage > 0;
  }
}
