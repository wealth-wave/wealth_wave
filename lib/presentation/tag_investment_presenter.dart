import 'package:wealth_wave/api/db/app_database.dart';
import 'package:wealth_wave/core/presenter.dart';
import 'package:wealth_wave/core/single_event.dart';
import 'package:wealth_wave/domain/models/goal.dart';
import 'package:wealth_wave/domain/models/investment.dart';

class TagInvestmentPresenter extends Presenter<TagInvestmentViewState> {
  final Goal _goal;

  TagInvestmentPresenter({required final Goal goal})
      : _goal = goal,
        super(TagInvestmentViewState());

  void onInvestmentSelected(int? investmentId) {
    updateViewState((viewState) => viewState.investmentId = investmentId);
  }

  void tagInvestment({required final Investment investment}) {
    final double sharePercentage = getViewState().sharePercentage;
    _goal.tagInvestment(investment: investment, split: sharePercentage).then(
        (_) => updateViewState(
            (viewState) => viewState.onInvestmentTagged = SingleEvent(null)));
  }

  void updateTaggedInvestment({required final Investment investment}) {
    final double sharePercentage = getViewState().sharePercentage;
    _goal
        .updateTaggedInvestment(investment: investment, split: sharePercentage)
        .then((_) => updateViewState(
            (viewState) => viewState.onInvestmentTagged = SingleEvent(null)));
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
