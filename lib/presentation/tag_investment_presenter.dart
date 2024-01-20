import 'package:wealth_wave/core/presenter.dart';
import 'package:wealth_wave/core/single_event.dart';
import 'package:wealth_wave/domain/models/investment.dart';
import 'package:wealth_wave/domain/services/goal_investment_service.dart';
import 'package:wealth_wave/domain/services/goal_service.dart';
import 'package:wealth_wave/domain/services/investment_service.dart';

class TagInvestmentPresenter extends Presenter<TagInvestmentViewState> {
  final int _goalId;
  final GoalService _goalService;
  final GoalInvestmentService _goalInvestmentService;
  final InvestmentService _investmentService;

  TagInvestmentPresenter(
      {required final int goalId,
      final GoalService? goalService,
      final InvestmentService? investmentService,
      final GoalInvestmentService? goalInvestmentService})
      : _goalId = goalId,
        _goalService = goalService ?? GoalService(),
        _investmentService = investmentService ?? InvestmentService(),
        _goalInvestmentService =
            goalInvestmentService ?? GoalInvestmentService(),
        super(TagInvestmentViewState());

  void onInvestmentSelected(int? investmentId) {
    updateViewState((viewState) => viewState.investmentId = investmentId);
  }

  void fetchInvestments() {
    _investmentService.get().then((investments) =>
        updateViewState((viewState) => viewState.investments = investments));
  }

  void tagInvestment({final int? idToUpdate}) {
    final double sharePercentage = getViewState().sharePercentage;
    final int? investmentId = getViewState().investmentId;

    if (investmentId != null && sharePercentage > 0) {
      if (idToUpdate != null) {
        _goalService
            .getBy(id: _goalId)
            .then((goal) => goal.updateTaggedInvestment(
                id: idToUpdate,
                investmentId: investmentId,
                split: sharePercentage))
            .then((_) => updateViewState((viewState) =>
                viewState.onInvestmentTagged = SingleEvent(null)));
      } else {
        _goalService
            .getBy(id: _goalId)
            .then((goal) => goal.tagInvestment(
                investmentId: investmentId, split: sharePercentage))
            .then((_) => updateViewState((viewState) =>
                viewState.onInvestmentTagged = SingleEvent(null)));
      }
    }
  }

  void onPercentageChanged(double text) {
    updateViewState((viewState) => viewState.sharePercentage = text);
  }

  void fetchGoalInvestment({required final int idToUpdate}) {
    _goalInvestmentService
        .getBy(id: idToUpdate)
        .then((goalInvestment) => updateViewState((viewState) {
              viewState.investmentId = goalInvestment.investmentId;
              viewState.sharePercentage = goalInvestment.splitPercentage;
              viewState.onInvestmentTagLoaded = SingleEvent(null);
            }));
  }
}

class TagInvestmentViewState {
  int? investmentId;
  double sharePercentage = 100;
  List<Investment> investments = [];
  SingleEvent<void>? onInvestmentTagged;
  SingleEvent<void>? onInvestmentTagLoaded;

  bool isValid() {
    return investmentId != null && sharePercentage > 0;
  }
}
