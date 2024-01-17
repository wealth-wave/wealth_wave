import 'package:wealth_wave/core/presenter.dart';
import 'package:wealth_wave/domain/models/goal.dart';
import 'package:wealth_wave/domain/models/investment.dart';

class TaggedInvestmentPresenter extends Presenter<TaggedInvestmentsViewState> {
  final Goal _goal;

  TaggedInvestmentPresenter({required final Goal goal})
      : _goal = goal,
        super(TaggedInvestmentsViewState());

  void fetchTaggedInvestment() {
    _goal.getInvestments().then((value) => updateViewState((viewState) {
          viewState.taggedInvestments = value;
        }));
  }

  void deleteTaggedInvestment({required final Investment investment}) {
    _goal.deleteTaggedInvestment(investment: investment).then((_) {
      fetchTaggedInvestment();
    });
  }
}

class TaggedInvestmentsViewState {
  Map<Investment, double> taggedInvestments = {};
}
