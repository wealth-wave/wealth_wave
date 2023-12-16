import 'package:wealth_wave/core/presenter.dart';
import 'package:wealth_wave/domain/models/goal.dart';
import 'package:wealth_wave/domain/use_cases/goal/create_goal_use_case.dart';
import 'package:wealth_wave/domain/use_cases/goal/delete_goal_use_case.dart';
import 'package:wealth_wave/domain/use_cases/goal/get_goal_list_use_case.dart';
import 'package:wealth_wave/domain/use_cases/goal/update_goal_use_case.dart';

class GoalsPagePresenter extends Presenter<GoalsPageViewState> {
  final GetGoalListUseCase _getGoalsUseCase;
  final DeleteGoalUseCase _deleteGoalUseCase;

  GoalsPagePresenter({
    final CreateGoalUseCase? createGoalUseCase,
    final GetGoalListUseCase? getGoalsUseCase,
    final UpdateGoalUseCase? updateGoalUseCase,
    final DeleteGoalUseCase? deleteGoalUseCase,
  })  : _getGoalsUseCase = getGoalsUseCase ?? GetGoalListUseCase(),
        _deleteGoalUseCase = deleteGoalUseCase ?? DeleteGoalUseCase(),
        super(GoalsPageViewState());

  void fetchGoals() {
    _getGoalsUseCase.getGoals().listen((goals) => updateViewState((viewState) {
          viewState.goals = goals;
        }));
  }

  void deleteGoal({required final int id}) {
    _deleteGoalUseCase.deleteGoal(id: id).then((_) => fetchGoals());
  }
}

class GoalsPageViewState {
  List<Goal> goals = [];
}
