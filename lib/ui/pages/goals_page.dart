import 'package:flutter/material.dart';
import 'package:wealth_wave/contract/goal_importance.dart';
import 'package:wealth_wave/core/page_state.dart';
import 'package:wealth_wave/presentation/goals_presenter.dart';
import 'package:wealth_wave/ui/app_dimen.dart';
import 'package:wealth_wave/ui/widgets/create_goal_dialog.dart';
import 'package:wealth_wave/ui/widgets/view_tagged_investment_dialog.dart';
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
    List<GoalVO> goalVOs = snapshot.goalVOs;
    return Scaffold(
      body: Center(
          child: ListView.builder(
        itemCount: goalVOs.length,
        itemBuilder: (context, index) {
          GoalVO goalVO = goalVOs[index];
          return _goalWidget(context: context, goalVO: goalVO);
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
      {required final BuildContext context, required final GoalVO goalVO}) {
    return Card(
        margin: const EdgeInsets.all(AppDimen.defaultPadding),
        child: Padding(
          padding: const EdgeInsets.all(AppDimen.defaultPadding),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Expanded(
                      flex: 1,
                      child: Text(goalVO.name,
                          overflow: TextOverflow.ellipsis,
                          style: Theme.of(context).textTheme.titleMedium)),
                  _infoToolTip(goalVO, context),
                  Text('(${_getYearsLeft(goalVO.yearsLeft)})',
                      style: Theme.of(context).textTheme.labelSmall),
                  PopupMenuButton<int>(
                    onSelected: (value) {
                      if (value == 1) {
                        showCreateGoalDialog(
                                context: context, goalIdToUpdate: goalVO.id)
                            .then((value) => presenter.fetchGoals());
                      } else if (value == 2) {
                        presenter.deleteGoal(id: goalVO.id);
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
                  const Spacer(flex: 1),
                  TextButton(
                    onPressed: () {
                      showTaggedInvestmentDialog(
                              context: context, goalId: goalVO.id)
                          .then((value) => presenter.fetchGoals());
                    },
                    child: Text('${goalVO.taggedInvestmentCount} investments'),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(formatToCurrency(goalVO.investedAmount),
                          style: Theme.of(context).textTheme.bodyMedium),
                      Text('(Invested)',
                          style: Theme.of(context).textTheme.labelSmall),
                    ],
                  ),
                  const SizedBox(width: AppDimen.minPadding), //
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(formatToCurrency(goalVO.valueOnMaturity),
                          style: Theme.of(context).textTheme.bodyMedium),
                      Text('(At ${formatToPercentage(goalVO.irr)})',
                          style: Theme.of(context).textTheme.labelSmall),
                    ],
                  ),
                  Expanded(
                      child: Padding(
                          padding:
                              const EdgeInsets.all(AppDimen.defaultPadding),
                          child: LinearProgressIndicator(
                            value: goalVO.progress,
                            semanticsLabel: 'progress',
                          ))),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(formatToCurrency(goalVO.maturityAmount),
                          style: Theme.of(context).textTheme.bodyMedium),
                      Text('(Target)',
                          style: Theme.of(context).textTheme.labelSmall),
                      Text(formatToPercentage(goalVO.inflation),
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
      return 'Matured';
    } else if (yearsLeft < 1) {
      return '${(yearsLeft * 12).round()} months';
    } else {
      return '${yearsLeft.round()} yrs';
    }
  }

  Tooltip _infoToolTip(GoalVO goalVO, BuildContext context) {
    final String? description = goalVO.description;
    final List<Widget> widgets = [];
    if (description?.isNotEmpty == true) {
      widgets.add(Text(description ?? '',
          style: Theme.of(context).textTheme.labelSmall));
    }
    widgets.add(Text('Importance: ${_getImportance(goalVO.importance)}',
        style: Theme.of(context).textTheme.labelSmall));
    return Tooltip(
        richMessage: WidgetSpan(child: Column(children: widgets)),
        child: const Icon(Icons.info));
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
