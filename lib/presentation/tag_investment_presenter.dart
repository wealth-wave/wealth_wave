import 'package:wealth_wave/api/db/app_database.dart';
import 'package:wealth_wave/core/presenter.dart';
import 'package:wealth_wave/core/single_event.dart';
import 'package:wealth_wave/domain/services/goal_service.dart';
import 'package:wealth_wave/domain/services/investment_service.dart';

class TagInvestmentPresenter extends Presenter<TagInvestmentViewState> {
  final int _goalId;
  final GoalService _goalService;

  TagInvestmentPresenter(
      {required final int goalId,
      final GoalService? goalService,
      final InvestmentService? investmentService})
      : _goalId = goalId,
        _goalService = goalService ?? GoalService(),
        super(TagInvestmentViewState());

  void onInvestmentSelected(int? investmentId) {
    updateViewState((viewState) => viewState.investmentId = investmentId);
  }

  void fetchInvesments() {}

  void tagInvestment() {
    final double sharePercentage = getViewState().sharePercentage;
    final int? investmentId = getViewState().investmentId;

    if (investmentId != null && sharePercentage > 0) {
      _goalService
          .getBy(id: _goalId)
          .then((goal) => goal.tagInvestment(
              investmentId: investmentId, split: sharePercentage))
          .then((_) => updateViewState(
              (viewState) => viewState.onInvestmentTagged = SingleEvent(null)));
    }
  }

  void updateTaggedInvestment(
      {required final int id, required final int investmentId}) {
    final double sharePercentage = getViewState().sharePercentage;
    final int? investmentId = getViewState().investmentId;

    if (investmentId != null && sharePercentage > 0) {
      _goalService
          .getBy(id: _goalId)
          .then((goal) => goal.updateTaggedInvestment(
              id: id, investmentId: investmentId, split: sharePercentage))
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
  int? investmentId;
  double sharePercentage = 100;
  List<InvestmentDO> investments = [];
  SingleEvent<void>? onInvestmentTagged;

  bool isValid() {
    return investmentId != null && sharePercentage > 0;
  }
}
