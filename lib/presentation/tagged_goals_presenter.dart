import 'package:wealth_wave/api/apis/investment_api.dart';
import 'package:wealth_wave/api/db/app_database.dart';
import 'package:wealth_wave/core/presenter.dart';

class TaggedGoalsPresenter extends Presenter<TaggedGoalsViewState> {
  final InvestmentApi _investmentApi;
  final int investmentId;

  TaggedGoalsPresenter(this.investmentId, {final InvestmentApi? investmentApi})
      : _investmentApi = investmentApi ?? InvestmentApi(),
        super(TaggedGoalsViewState(investmentId: investmentId));

  void fetchTaggedInvestment() {
    _investmentApi
        .getGoalInvestmentMappings(investmentId: investmentId)
        .then((value) => updateViewState((viewState) {
              viewState.taggedGoals = value;
            }));
  }

  void deleteTaggedInvestment({required final int id}) {
    _investmentApi.deleteGoalInvestmentMap(id: id).then((_) {
      fetchTaggedInvestment();
    });
  }
}

class TaggedGoalsViewState {
  final int investmentId;
  List<GoalInvestmentEnrichedMappingDO> taggedGoals = [];

  TaggedGoalsViewState({required this.investmentId});
}
