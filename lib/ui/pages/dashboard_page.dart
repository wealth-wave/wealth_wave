import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pair/pair.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:primer_progress_bar/primer_progress_bar.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:wealth_wave/contract/risk_level.dart';
import 'package:wealth_wave/core/page_state.dart';
import 'package:wealth_wave/ui/presentation/dashboard_presenter.dart';
import 'package:wealth_wave/ui/app_dimen.dart';
import 'package:wealth_wave/utils/ui_utils.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPage();
}

class _DashboardPage
    extends PageState<DashboardViewState, DashboardPage, DashboardPresenter> {
  @override
  void initState() {
    super.initState();
    presenter.fetchDashboard();
  }

  @override
  Widget buildWidget(
      final BuildContext context, final DashboardViewState snapshot) {
    final irrComposition = snapshot.irrComposition.entries.toList();
    irrComposition.sort((a, b) => a.key.compareTo(b.key));

    return Scaffold(
      appBar: AppBar(
        title: const Text('Investment Portfolio Dashboard'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(AppDimen.defaultPadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Text('Progress:', style: Theme.of(context).textTheme.titleMedium),
              const SizedBox(height: AppDimen.minPadding),
              _buildInvestmentProgress(
                  investedAmount: snapshot.invested,
                  valueOfInvestment: snapshot.currentValue,
                  irr: snapshot.overallIRR),
              const SizedBox(height: AppDimen.defaultPadding),
              Text('Basket Composition:',
                  style: Theme.of(context).textTheme.titleMedium),
              const SizedBox(height: AppDimen.minPadding),
              _buildBarChart(snapshot.basketComposition.entries.toList(), snapshot.currentValue),
              const SizedBox(height: AppDimen.defaultPadding),
              Text('Risk Composition:',
                  style: Theme.of(context).textTheme.titleMedium),
              const SizedBox(height: AppDimen.minPadding),
              _buildPieChart(snapshot.riskComposition),
              const SizedBox(height: AppDimen.defaultPadding),
              Text('IRR Contribution:',
                  style: Theme.of(context).textTheme.titleMedium),
              const SizedBox(height: AppDimen.minPadding),
              _buildAmountIrrContribution(
                  context: context,
                  irrData: snapshot.irrGroups.entries.toList()),
              Text('Basket IRR:',
                  style: Theme.of(context).textTheme.titleMedium),
              const SizedBox(height: AppDimen.minPadding),
              _buildIrrContribution(data: snapshot.basketIrr.entries.toList()),
              const SizedBox(height: AppDimen.defaultPadding),
              Text('Investment Over Time:',
                  style: Theme.of(context).textTheme.titleMedium),
              const SizedBox(height: AppDimen.minPadding),
              _buildTimeLine(snapshot.valueOverTime.entries.toList(),
                  snapshot.investmentOverTime.entries.toList()),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPieChart(Map<RiskLevel, double> data) {
    if (data.isNotEmpty) {
      List<RiskLevel> sortedKeys = data.keys.toList()
        ..sort((a, b) => a.intValue.compareTo(b.intValue));

      return PieChart(
          chartRadius: MediaQuery.of(context).size.width / 4,
          colorList: _getColorList(data),
          dataMap: sortedKeys.fold(
              {},
              (map, key) =>
                  {...map, _getRiskLevelName(key): (data[key] ?? 0) * 100}));
    }
    return const Text('');
  }

  Widget _buildInvestmentProgress(
      {required double investedAmount,
      required double valueOfInvestment,
      required double irr}) {
    if (investedAmount == 0 || valueOfInvestment == 0) {
      return const Text('');
    }

    bool isValueGreater = valueOfInvestment > investedAmount;
    double percentage = isValueGreater
        ? (investedAmount / valueOfInvestment * 100)
        : (valueOfInvestment / investedAmount * 100);
    double remainingPercentage = 100 - percentage;

    return PrimerProgressBar(
      segments: [
        _buildSegment(percentage, investedAmount, 'Invested', Colors.blue),
        _buildSegment(
            remainingPercentage,
            valueOfInvestment,
            'Current Value(at ${formatToPercentage(irr)})',
            isValueGreater ? Colors.green : Colors.red),
      ],
    );
  }

  Segment _buildSegment(
      double value, double amount, String label, Color color) {
    return Segment(
      value: value.toInt(),
      valueLabel: Text(formatToCurrency(amount)),
      label: Text(label),
      color: color,
    );
  }

  Widget _buildBarChart(List<MapEntry<String, double>> data, double currentValue) {
    data.sort((a, b) => a.value > b.value ? -1 : 1);
    return PrimerProgressBar(
      segments: data
          .map((e) => Segment(
              value: (e.value).toInt(),
              valueLabel: Text('${formatToCurrency(e.value)} (${formatToPercentage(e.value * 100/ currentValue)})'),
              label: Text(e.key),
              color:
                  Colors.primaries[e.key.hashCode % Colors.primaries.length]))
          .toList(),
    );
  }

  Widget _buildTimeLine(final List<MapEntry<DateTime, double>> valueData,
      final List<MapEntry<DateTime, double>> investedData) {
    if (valueData.isNotEmpty && investedData.isNotEmpty) {
      return SfCartesianChart(
        primaryXAxis: const DateTimeAxis(),
        primaryYAxis: NumericAxis(
            numberFormat: NumberFormat.compactCurrency(
                symbol: '', locale: 'en_IN', decimalDigits: 0)),
        series: [
          LineSeries<MapEntry<DateTime, double>, DateTime>(
            color: Colors.green,
            dataSource: valueData,
            xValueMapper: (MapEntry<DateTime, double> entry, _) => entry.key,
            yValueMapper: (MapEntry<DateTime, double> entry, _) => entry.value,
            name: 'Invested Value',
          ),
          LineSeries<MapEntry<DateTime, double>, DateTime>(
            color: Colors.blue,
            dataSource: investedData,
            xValueMapper: (MapEntry<DateTime, double> entry, _) => entry.key,
            yValueMapper: (MapEntry<DateTime, double> entry, _) => entry.value,
            name: 'Invested Amount',
          ),
        ],
        tooltipBehavior: TooltipBehavior(enable: true),
      );
    }
    return const Text('');
  }

  Widget _buildIrrContribution(
      {required final List<MapEntry<String, double>> data}) {
    if (data.isNotEmpty) {
      data.sort((a, b) => a.value.compareTo(b.value));
      List<MapEntry<String, double>> contribution = [];
      for (var element in data) {
        contribution.add(MapEntry(element.key, element.value));
      }
      return SfCartesianChart(
        primaryXAxis: const CategoryAxis(),
        series: [
          BarSeries(
            dataSource: contribution,
            xValueMapper: (data, _) => data.key,
            yValueMapper: (data, _) => data.value,
          ),
        ],
      );
    } else {
      return const Text('');
    }
  }

  Widget _buildAmountIrrContribution(
      {required final BuildContext context,
      required final List<MapEntry<int, Pair<double, double>>> irrData}) {
    if (irrData.isNotEmpty) {
      irrData.sort((a, b) => a.key.compareTo(b.key));
      List<MapEntry<int, double>> invested = [];
      List<MapEntry<int, double>> value = [];
      for (var element in irrData) {
        invested.add(MapEntry(element.key, element.value.key));
        value.add(
            MapEntry(element.key, element.value.value - element.value.key));
      }
      return SfCartesianChart(
        primaryXAxis: CategoryAxis(
          axisLabelFormatter: (axisLabelRenderArgs) => ChartAxisLabel(
              '${axisLabelRenderArgs.text} %+', axisLabelRenderArgs.textStyle),
        ),
        primaryYAxis: NumericAxis(
            numberFormat: NumberFormat.compactCurrency(
                symbol: '', locale: 'en_IN', decimalDigits: 0)),
        series: [
          StackedBarSeries(
            dataSource: invested,
            xValueMapper: (data, _) => data.key,
            yValueMapper: (data, _) => data.value,
          ),
          StackedBarSeries(
            dataSource: value,
            xValueMapper: (data, _) => data.key,
            yValueMapper: (data, _) => data.value,
          ),
        ],
      );
    } else {
      return const Text('');
    }
  }

  String _getRiskLevelName(RiskLevel riskLevel) {
    switch (riskLevel) {
      case RiskLevel.veryLow:
        return 'Very Low Risk';
      case RiskLevel.low:
        return 'Low Risk';
      case RiskLevel.medium:
        return 'Medium Risk';
      case RiskLevel.high:
        return 'High Risk';
      case RiskLevel.veryHigh:
        return 'Very High Risk';
    }
  }

  Color _getColorForRiskLevel(RiskLevel key) {
    switch (key) {
      case RiskLevel.veryLow:
        return Colors.lightGreen;
      case RiskLevel.low:
        return Colors.green;
      case RiskLevel.medium:
        return Colors.yellow;
      case RiskLevel.high:
        return Colors.orange;
      case RiskLevel.veryHigh:
        return Colors.red;
    }
  }

  List<Color> _getColorList(Map<RiskLevel, double> value) {
    List<Color> colors = [];

    List<RiskLevel> sortedKeys = value.keys.toList()
      ..sort((a, b) => a.intValue.compareTo(b.intValue));

    for (var element in sortedKeys) {
      colors.add(_getColorForRiskLevel(element));
    }

    return colors;
  }

  @override
  DashboardPresenter initializePresenter() {
    return DashboardPresenter();
  }
}
