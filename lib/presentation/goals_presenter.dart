import 'package:wealth_wave/core/presenter.dart';
import 'package:wealth_wave/domain/models/goal.dart';
import 'package:wealth_wave/domain/models/investment.dart';
import 'package:wealth_wave/domain/services/goal_service.dart';

class GoalsPresenter extends Presenter<GoalsViewState> {
  final GoalService _goalService;

  GoalsPresenter({final GoalService? goalService})
      : _goalService = goalService ?? GoalService(),
        super(GoalsViewState());

  void fetchGoals() {
    _goalService
        .get()
        .then((goals) => Future.wait(goals.map((goal) async {
              final valueOnMaturity = await goal.getValueOnMaturity();
              final investments = await goal.getInvestments();
              final maturityAmount = await goal.getMaturityAmount();

              return GoalVO(
                  id: goal.id,
                  name: goal.name,
                  description: goal.description,
                  goal: goal,
                  maturityAmount: maturityAmount,
                  maturityDate: goal.maturityDate,
                  valueOnMaturity: valueOnMaturity,
                  investments: investments);
            })))
        .then((goalVOs) =>
            updateViewState((viewState) => viewState.goals = goalVOs));
  }

  void deleteGoal({required final int id}) {
    _goalService.deleteBy(id: id).then((_) => fetchGoals());
  }
}

class GoalsViewState {
  List<GoalVO> goals = [];
}

class GoalVO {
  final int id;
  final String name;
  final String? description;
  final double maturityAmount;
  final DateTime maturityDate;
  final double valueOnMaturity;
  final Goal goal;
  final Map<Investment, double> investments;

  GoalVO(
      {required this.id,
      required this.name,
      required this.description,
      required this.maturityAmount,
      required this.maturityDate,
      required this.valueOnMaturity,
      required this.goal,
      required this.investments});
}
