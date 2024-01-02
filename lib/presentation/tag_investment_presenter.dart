import 'package:wealth_wave/api/apis/goal_api.dart';
import 'package:wealth_wave/api/apis/investment_api.dart';
import 'package:wealth_wave/api/db/app_database.dart';
import 'package:wealth_wave/core/presenter.dart';
import 'package:wealth_wave/core/single_event.dart';

class TagInvestmentPresenter extends Presenter<TagInvestmentViewState> {
  final GoalApi _goalApi;
  final InvestmentApi _investmentApi;
  final int goalId;

  TagInvestmentPresenter(this.goalId,
      {final InvestmentApi? investmentApi, final GoalApi? goalApi})
      : _investmentApi = investmentApi ?? InvestmentApi(),
        _goalApi = goalApi ?? GoalApi(),
        super(TagInvestmentViewState(goalId: goalId));

  void getInvestments() {
    _investmentApi.getInvestments().then((investments) =>
        updateViewState((viewState) => viewState.investments = investments));
  }

  void onInvestmentSelected(int? investmentId) {
    updateViewState((viewState) => viewState.investmentId = investmentId);
  }

  void tagInvestment({int? id}) {
    final int? investmentId = getViewState().investmentId;
    final double sharePercentage = getViewState().sharePercentage;

    if (investmentId == null) {
      return;
    }

    if (id != null) {
      _goalApi
          .updateGoalInvestmentMap(
              id: id, investmentId: investmentId, percentage: sharePercentage)
          .then((_) => updateViewState(
              (viewState) => viewState.onInvestmentTagged = SingleEvent(null)));
    } else {
      _goalApi
          .createGoalInvestmentMap(
              goalId: goalId,
              investmentId: investmentId,
              percentage: sharePercentage)
          .then((_) => updateViewState(
              (viewState) => viewState.onInvestmentTagged = SingleEvent(null)));
    }
  }

  void onPercentageChanged(String text) {
    updateViewState((viewState) =>
        viewState.sharePercentage = double.tryParse(text) ?? 0.0);
  }
}

class TagInvestmentViewState {
  final int goalId;
  int? investmentId;
  double sharePercentage = 100;
  List<InvestmentDO> investments = [];
  SingleEvent<void>? onInvestmentTagged;

  TagInvestmentViewState({required this.goalId});

  bool isValid() {
    return investmentId != null && sharePercentage > 0;
  }
}
