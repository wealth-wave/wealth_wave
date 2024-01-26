import 'package:flutter/material.dart';
import 'package:primer_progress_bar/primer_progress_bar.dart';
import 'package:wealth_wave/contract/goal_health.dart';
import 'package:wealth_wave/contract/goal_importance.dart';
import 'package:wealth_wave/contract/risk_level.dart';
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
                          child: PrimerProgressBar(
                            segments: _getProgressSegments(goalVO, context),
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
              Padding(
                  padding: const EdgeInsets.all(AppDimen.defaultPadding),
                  child: PrimerProgressBar(
                    segments: _getRiskCompositionSegments(goalVO, context),
                  )),
            ],
          ),
        ));
  }

  List<Segment> _getProgressSegments(GoalVO goalVO, BuildContext context) {
    List<Segment> segments = [];
    if (goalVO.currentProgressPercent == 100) {
      segments.add(
        Segment(
            value: (goalVO.currentProgressPercent).toInt(),
            label: const Text('Current Value'),
            valueLabel: Text(formatToPercentage(goalVO.currentProgressPercent),
                style: Theme.of(context).textTheme.labelSmall),
            color:
                goalVO.health == GoalHealth.good ? Colors.green : Colors.red),
      );
    } else {
      segments.add(
        Segment(
            value: (goalVO.currentProgressPercent).toInt(),
            label: const Text('Current Value'),
            valueLabel: Text(formatToPercentage(goalVO.currentProgressPercent),
                style: Theme.of(context).textTheme.labelSmall),
            color:
                goalVO.health == GoalHealth.good ? Colors.green : Colors.red),
      );
      if (goalVO.maturityProgressPercent > goalVO.currentProgressPercent) {
        segments.add(
          Segment(
              value: (goalVO.maturityProgressPercent -
                      goalVO.currentProgressPercent)
                  .toInt(),
              label: const Text('Maturity Value'),
              valueLabel: Text(
                  formatToPercentage(goalVO.maturityProgressPercent),
                  style: Theme.of(context).textTheme.labelSmall),
              color: goalVO.health == GoalHealth.good
                  ? Colors.lightGreen
                  : Colors.orange),
        );
      }
      segments.add(Segment(
          value: (goalVO.pendingProgressPercent).toInt(),
          label: const Text('Health:'),
          valueLabel: Text(goalVO.health == GoalHealth.good ? 'Good' : 'Risky',
              style: Theme.of(context).textTheme.labelSmall!.copyWith(
                  color: goalVO.health == GoalHealth.good
                      ? Colors.green
                      : Colors.red)),
          color: Colors.transparent));
    }
    return segments;
  }

  List<Segment> _getRiskCompositionSegments(
      GoalVO goalVO, BuildContext context) {
    List<Segment> segments = [];

    Map<RiskLevel, double> riskComposition = goalVO.riskLevelDistribution;
    if (riskComposition.containsKey(RiskLevel.low)) {
      segments.add(Segment(
          value: (goalVO.lowRiskProgressPercent).toInt(),
          label: const Text('Low Risk'),
          valueLabel: Text(formatToPercentage(goalVO.lowRiskProgressPercent),
              style: Theme.of(context).textTheme.labelSmall),
          color: Colors.green));
    }
    if (riskComposition.containsKey(RiskLevel.medium)) {
      segments.add(Segment(
          value: (goalVO.mediumRiskProgressPercent).toInt(),
          label: const Text('Medium Risk'),
          valueLabel: Text(formatToPercentage(goalVO.mediumRiskProgressPercent),
              style: Theme.of(context).textTheme.labelSmall),
          color: Colors.orange));
    }
    if (riskComposition.containsKey(RiskLevel.high)) {
      segments.add(Segment(
          value: (goalVO.highRiskProgressPercent).toInt(),
          label: const Text('High Risk'),
          valueLabel: Text(formatToPercentage(goalVO.highRiskProgressPercent),
              style: Theme.of(context).textTheme.labelSmall),
          color: Colors.red));
    }

    return segments;
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
