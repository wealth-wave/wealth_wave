import 'package:wealth_wave/core/presenter.dart';
import 'package:wealth_wave/domain/models/goal.dart';
import 'package:wealth_wave/domain/models/investment.dart';

class TaggedGoalsPresenter extends Presenter<TaggedGoalsViewState> {
  final Investment _investment;

  TaggedGoalsPresenter({required final Investment investment})
      : _investment = investment,
        super(TaggedGoalsViewState());

  void fetchTaggedInvestment() {
    _investment.getGoals().then((value) => updateViewState((viewState) {
          viewState.taggedGoals = value;
        }));
  }

  void deleteTaggedInvestment({required final Goal goal}) {
    _investment.deleteTaggedGoal(goal: goal).then((_) {
      fetchTaggedInvestment();
    });
  }
}

class TaggedGoalsViewState {
  Map<Goal, double> taggedGoals = {};

  TaggedGoalsViewState();
}
