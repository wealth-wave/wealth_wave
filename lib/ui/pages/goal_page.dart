import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:primer_progress_bar/primer_progress_bar.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:wealth_wave/contract/goal_importance.dart';
import 'package:wealth_wave/core/page_state.dart';
import 'package:wealth_wave/ui/presentation/goal_presenter.dart';
import 'package:wealth_wave/ui/app_dimen.dart';
import 'package:wealth_wave/utils/ui_utils.dart';

class GoalPage extends StatefulWidget {
  final int goalId;

  const GoalPage({super.key, required this.goalId});

  @override
  State<GoalPage> createState() => _GoalPage();
}

class _GoalPage extends PageState<GoalViewState, GoalPage, GoalPresenter> {
  @override
  void initState() {
    super.initState();
    presenter.fetchGoal(id: widget.goalId);
  }

  @override
  Widget buildWidget(BuildContext context, GoalViewState snapshot) {
    GoalVO? goalVO = snapshot.goalVO;

    if (goalVO == null) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

return Scaffold(
        appBar: AppBar(
          title: const Text('Goal'),
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        ),
        body: SingleChildScrollView(
            child: _goalWidget(context: context, goalVO: goalVO)));
  }

  @override
  GoalPresenter initializePresenter() {
    return GoalPresenter();
  }

  Widget _goalWidget(
      {required final BuildContext context, required final GoalVO goalVO}) {
    return Column(children: [
      Card(
          margin: const EdgeInsets.all(AppDimen.defaultPadding),
          child: Padding(
            padding: const EdgeInsets.all(AppDimen.defaultPadding),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        _getTitleWidget(goalVO, context),
                        Text('${goalVO.taggedInvestmentCount} investments'),
                      ],
                    ),
                    Column(
                      children: [
                        Text(formatToCurrency(goalVO.maturityAmount),
                            style: Theme.of(context).textTheme.bodyLarge),
                        Text(
                            'At ${formatToPercentage(goalVO.inflation)} inflation',
                            style: Theme.of(context).textTheme.labelMedium),
                      ],
                    ),
                  ],
                ),
                PrimerProgressBar(
                  segments: _getProgressSegments(goalVO, context),
                ),
                const Padding(padding: EdgeInsets.all(AppDimen.minPadding)),
                _getSuggestions(context, goalVO)
              ],
            ),
          )),
      _buildTimeLine(
        goalVO.goalAmountOverTime.entries.toList(),
        goalVO.investedValueOverTime.entries.toList(),
        goalVO.investmentAmountOverTime.entries.toList(),
      )
    ]);
  }

  Column _getSuggestions(BuildContext context, GoalVO goalVO) {
    return Column(
      children: goalVO.healthSuggestions.map((suggestion) {
        return Padding(
          padding: const EdgeInsets.all(AppDimen.textPadding),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              const Text('•  ',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              Expanded(
                child: Text(suggestion,
                    style: Theme.of(context).textTheme.bodyMedium),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }

  List<Segment> _getProgressSegments(GoalVO goalVO, BuildContext context) {
    List<Segment> segments = [];
    if (goalVO.currentProgressPercent == 100) {
      segments.add(
        Segment(
            value: (goalVO.currentProgressPercent).toInt(),
            label: const Text('Current Value'),
            valueLabel: Text(formatToCurrency(goalVO.currentValue),
                style: Theme.of(context).textTheme.bodyMedium),
            color:
                goalVO.healthSuggestions.isEmpty ? Colors.green : Colors.red),
      );
    } else {
      segments.add(
        Segment(
            value: (goalVO.currentProgressPercent).toInt(),
            label: const Text('Current Value'),
            valueLabel: Text(formatToCurrency(goalVO.currentValue),
                style: Theme.of(context).textTheme.bodyMedium),
            color:
                goalVO.healthSuggestions.isEmpty ? Colors.green : Colors.red),
      );
      if (goalVO.maturityProgressPercent > goalVO.currentProgressPercent) {
        segments.add(
          Segment(
              value: (goalVO.maturityProgressPercent -
                      goalVO.currentProgressPercent)
                  .toInt(),
              label: const Text('Maturity Value'),
              valueLabel: Text(formatToCurrency(goalVO.valueOnMaturity),
                  style: Theme.of(context).textTheme.bodyMedium),
              color: goalVO.healthSuggestions.isEmpty
                  ? Colors.lightGreen
                  : Colors.orange),
        );
      }
      segments.add(Segment(
          value: (goalVO.pendingProgressPercent).toInt(),
          label: const Text('Health:'),
          valueLabel: Text(goalVO.healthSuggestions.isEmpty ? 'Good' : 'Risky',
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  color: goalVO.healthSuggestions.isEmpty
                      ? Colors.green
                      : Colors.red)),
          color: Colors.transparent));
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

  RichText _getTitleWidget(GoalVO goalVO, BuildContext context) {
    List<WidgetSpan> widgets = [];
    bool isLowImportance = goalVO.importance == GoalImportance.low;
    if (!isLowImportance) {
      widgets.add(WidgetSpan(
          child: Text(' | ${_getImportance(goalVO.importance)}',
              style: Theme.of(context).textTheme.labelMedium)));
    }
    widgets.add(WidgetSpan(
        child: Text(' | ${_getYearsLeft(goalVO.yearsLeft)}',
            style: Theme.of(context).textTheme.labelMedium)));
    return RichText(
        text: TextSpan(
            text: goalVO.name,
            style: Theme.of(context).textTheme.titleMedium,
            children: widgets));
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

  Widget _buildTimeLine(
      final List<MapEntry<DateTime, double>> goalValueData,
      final List<MapEntry<DateTime, double>> investmentValueData,
      final List<MapEntry<DateTime, double>> investedAmountData) {
    if (investmentValueData.isNotEmpty &&
        investedAmountData.isNotEmpty &&
        goalValueData.isNotEmpty) {
      return SfCartesianChart(
        primaryXAxis: const DateTimeAxis(),
        primaryYAxis: NumericAxis(
            numberFormat: NumberFormat.compactCurrency(
                symbol: '', locale: 'en_IN', decimalDigits: 0)),
        series: [
          LineSeries<MapEntry<DateTime, double>, DateTime>(
            color: Colors.green,
            dataSource: investmentValueData,
            xValueMapper: (MapEntry<DateTime, double> entry, _) => entry.key,
            yValueMapper: (MapEntry<DateTime, double> entry, _) => entry.value,
            name: 'Invested Value',
          ),
          LineSeries<MapEntry<DateTime, double>, DateTime>(
            color: Colors.blue,
            dataSource: investedAmountData,
            xValueMapper: (MapEntry<DateTime, double> entry, _) => entry.key,
            yValueMapper: (MapEntry<DateTime, double> entry, _) => entry.value,
            name: 'Invested Amount',
          ),
          LineSeries<MapEntry<DateTime, double>, DateTime>(
            color: Colors.grey,
            dataSource: goalValueData,
            xValueMapper: (MapEntry<DateTime, double> entry, _) => entry.key,
            yValueMapper: (MapEntry<DateTime, double> entry, _) => entry.value,
            name: 'Goal Amount',
          ),
        ],
        tooltipBehavior: TooltipBehavior(enable: true),
      );
    }
    return const Text('');
  }
}
