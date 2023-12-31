import 'package:flutter/material.dart';
import 'package:wealth_wave/contract/goal_importance.dart';
import 'package:wealth_wave/core/page_state.dart';
import 'package:wealth_wave/domain/models/goal.dart';
import 'package:wealth_wave/presentation/goals_presenter.dart';
import 'package:wealth_wave/ui/app_dimen.dart';
import 'package:wealth_wave/ui/widgets/create_goal_dialog.dart';
import 'package:wealth_wave/ui/widgets/tagged_investment_dialog.dart';
import 'package:wealth_wave/utils/ui_utils.dart';

class GoalsPage extends StatefulWidget {
  const GoalsPage({super.key});

  @override
  State<GoalsPage> createState() => _GoalsPage();
}

class _GoalsPage extends PageState<GoalsViewState, GoalsPage, GoalsPresenter> {
  @override
  void initState() {
    super.initState();
    presenter.fetchGoals();
  }

  @override
  Widget buildWidget(BuildContext context, GoalsViewState snapshot) {
    List<Goal> goals = snapshot.goals;
    return Scaffold(
      body: Center(
          child: ListView.builder(
        itemCount: goals.length,
        itemBuilder: (context, index) {
          Goal goal = goals[index];
          return _goalWidget(context: context, goal: goal);
        },
      )),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showCreateGoalDialog(context: context)
              .then((value) => presenter.fetchGoals());
        },
        tooltip: 'Add',
        child: const Icon(Icons.add),
      ),
    );
  }

  @override
  GoalsPresenter initializePresenter() {
    return GoalsPresenter();
  }

  Widget _goalWidget(
      {required final BuildContext context, required final Goal goal}) {
    return Card(
        margin: const EdgeInsets.all(AppDimen.defaultPadding),
        child: Padding(
          padding: const EdgeInsets.all(AppDimen.defaultPadding),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(goal.name,
                          style: Theme.of(context).textTheme.titleMedium),
                      const Text(' | '),
                      Text(_getImportance(goal.importance)),
                      const Text(' | '),
                      Text('(${_getYearsLeft(goal.getYearsLeft())})'),
                      PopupMenuButton<int>(
                        onSelected: (value) {
                          if (value == 1) {
                            showCreateGoalDialog(context: context, goal: goal)
                                .then((value) => presenter.fetchGoals());
                          } else if (value == 2) {
                            presenter.deleteGoal(id: goal.id);
                          }
                        },
                        itemBuilder: (context) => [
                          const PopupMenuItem(
                            value: 1,
                            child: Text('Edit'),
                          ),
                          const PopupMenuItem(
                            value: 2,
                            child: Text('Delete'),
                          ),
                        ],
                      ),
                    ],
                  ),
                  TextButton(
                    onPressed: () {
                      showTaggedInvestmentDialog(
                              context: context, goalId: goal.id)
                          .then((value) => presenter.fetchGoals());
                    },
                    child: Text(
                        '${goal.taggedInvestments.length} tagged investments'),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(formatToCurrency(goal.getInvestedValue()),
                          style: Theme.of(context).textTheme.bodyMedium),
                      Text('(Invested Amount)',
                          style: Theme.of(context).textTheme.labelSmall),
                      Text(formatToPercentage(goal.getIrr()),
                          style: Theme.of(context).textTheme.bodyMedium),
                      Text('(Growth Rate)',
                          style: Theme.of(context).textTheme.labelSmall),
                    ],
                  ),
                  Expanded(
                      child: Padding(
                          padding:
                              const EdgeInsets.all(AppDimen.defaultPadding),
                          child: LinearProgressIndicator(
                            value: goal.getProgress(),
                            semanticsLabel: 'Investment progress',
                          ))),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(formatToCurrency(goal.targetAmount),
                          style: Theme.of(context).textTheme.bodyMedium),
                      Text('(Target Amount)',
                          style: Theme.of(context).textTheme.labelSmall),
                      Text(formatToPercentage(goal.inflation / 100),
                          style: Theme.of(context).textTheme.bodyMedium),
                      Text('(Inflation)',
                          style: Theme.of(context).textTheme.labelSmall),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ));
  }

  String _getYearsLeft(double yearsLeft) {
    if (yearsLeft < 0) {
      return 'Goal date passed';
    } else if (yearsLeft < 1) {
      return '${(yearsLeft * 12).round()} months left';
    } else {
      return '${yearsLeft.round()} years left';
    }
  }

  String _getImportance(GoalImportance importance) {
    switch (importance) {
      case GoalImportance.low:
        return 'Low';
      case GoalImportance.medium:
        return 'Medium';
      case GoalImportance.high:
        return 'High';
    }
  }
}
