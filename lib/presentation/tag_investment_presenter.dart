import 'package:wealth_wave/core/presenter.dart';
import 'package:wealth_wave/core/single_event.dart';
import 'package:wealth_wave/domain/models/investment.dart';
import 'package:wealth_wave/domain/services/goal_investment_service.dart';
import 'package:wealth_wave/domain/services/investment_service.dart';
import 'package:wealth_wave/utils/utils.dart';

class TagInvestmentPresenter extends Presenter<TagInvestmentViewState> {
  final int _goalId;
  final GoalInvestmentService _goalInvestmentService;
  final InvestmentService _investmentService;

  TagInvestmentPresenter(
      {required final int goalId,
      final InvestmentService? investmentService,
      final GoalInvestmentService? goalInvestmentService})
      : _goalId = goalId,
        _investmentService = investmentService ?? InvestmentService(),
        _goalInvestmentService =
            goalInvestmentService ?? GoalInvestmentService(),
        super(TagInvestmentViewState());

  void onInvestmentSelected(int? investmentId) {
    updateViewState((viewState) => viewState.investmentId = investmentId);
  }

  void fetchInvestments() {
    _goalInvestmentService.getBy(goalId: _goalId).then((goalInvestments) {
      final List<int> investmentIds =
          goalInvestments.map((e) => e.investmentId).toList();
      _investmentService.get().then((investments) {
        updateViewState((viewState) {
          viewState.investments = investments
              .where((element) => !investmentIds.contains(element.id))
              .toList();
        });
      });
    });
  }

  void tagInvestment({final int? idToUpdate}) {
    final double sharePercentage = getViewState().sharePercentage;
    final int? investmentId = getViewState().investmentId;

    if (investmentId != null && sharePercentage > 0) {
      if (idToUpdate != null) {
        _goalInvestmentService
            .updateTaggedGoalInvestment(
                id: idToUpdate,
                goalId: _goalId,
                investmentId: investmentId,
                split: sharePercentage)
            .then((_) => updateViewState((viewState) =>
                viewState.onInvestmentTagged = SingleEvent(null)));
      } else {
        _goalInvestmentService
            .tagGoalInvestment(
                investmentId: investmentId,
                goalId: _goalId,
                split: sharePercentage)
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
        .getById(id: idToUpdate)
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

  double get tagAmount {
    int? investmentId = this.investmentId;
    if (investmentId == null) {
      return 0.0;
    }
    double investmentValue = investments
        .firstWhere((element) => element.id == investmentId)
        .getValue();
    return calculatePercentageOfValue(
        value: investmentValue, percentage: sharePercentage);
  }

  bool isValid() {
    return investmentId != null &&
        sharePercentage > 0 &&
        sharePercentage <= 100;
  }
}
