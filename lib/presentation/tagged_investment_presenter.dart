import 'package:wealth_wave/api/apis/goal_api.dart';
import 'package:wealth_wave/api/db/app_database.dart';
import 'package:wealth_wave/core/presenter.dart';

class TaggedInvestmentPresenter extends Presenter<TaggedInvestmentsViewState> {
  final GoalApi _goalApi;
  final int goalId;

  TaggedInvestmentPresenter(this.goalId, {final GoalApi? goalApi})
      : _goalApi = goalApi ?? GoalApi(),
        super(TaggedInvestmentsViewState(goalId: goalId));

  void fetchTaggedInvestment() {
    _goalApi
        .getGoalInvestmentMappings(goalId: goalId)
        .then((value) => updateViewState((viewState) {
              viewState.taggedInvestments = value;
            }));
  }

  void deleteTaggedInvestment({required final int id}) {
    _goalApi.deleteGoalInvestmentMap(id: id).then((_) {
      fetchTaggedInvestment();
    });
  }
}

class TaggedInvestmentsViewState {
  final int goalId;
  List<GoalInvestmentEnrichedMappingDO> taggedInvestments = [];

  TaggedInvestmentsViewState({required this.goalId});
}
