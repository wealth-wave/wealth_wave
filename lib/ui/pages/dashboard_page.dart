import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:primer_progress_bar/primer_progress_bar.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:wealth_wave/contract/risk_level.dart';
import 'package:wealth_wave/core/page_state.dart';
import 'package:wealth_wave/presentation/dashboard_presenter.dart';
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
              Text(
                  'Total Invested Amount: ${formatToCurrency(snapshot.invested)}',
                  style: Theme.of(context).textTheme.bodyLarge),
              const SizedBox(height: AppDimen.minPadding),
              Text(
                  'Current Value of Investment: ${formatToCurrency(snapshot.currentValue)}',
                  style: Theme.of(context).textTheme.bodyLarge),
              const SizedBox(height: AppDimen.minPadding),
              Text('Risk Composition:',
                  style: Theme.of(context).textTheme.titleMedium),
              const SizedBox(height: AppDimen.minPadding),
              _buildPieChart(snapshot.riskComposition),
              const SizedBox(height: AppDimen.minPadding),
              Text('Basket Composition:',
                  style: Theme.of(context).textTheme.titleMedium),
              const SizedBox(height: AppDimen.minPadding),
              _buildBarChart(snapshot.basketComposition.entries.toList()),
              const SizedBox(height: AppDimen.minPadding),
              Text('IRR Composition:',
                  style: Theme.of(context).textTheme.titleMedium),
              const SizedBox(height: AppDimen.minPadding),
              _buildBarChart(irrComposition
                  .map((e) => MapEntry(formatToPercentage(e.key), e.value))
                  .toList()),
              const SizedBox(height: AppDimen.minPadding),
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
      return PieChart(
          chartRadius: MediaQuery.of(context).size.width / 4,
          colorList: _getColorList(data),
          dataMap: data.map(
              (key, value) => MapEntry(_getRiskLevelName(key), value * 100)));
    }
    return const Text('');
  }

  Widget _buildBarChart(List<MapEntry<String, double>> data) {
    return PrimerProgressBar(
      segments: data
          .map((e) => Segment(
              value: (e.value * 100).toInt(),
              valueLabel: Text(formatToPercentage(e.value * 100)),
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
        primaryYAxis: NumericAxis(numberFormat: NumberFormat.compactCurrency()),
        series: [
          LineSeries<MapEntry<DateTime, double>, DateTime>(
            dataSource: valueData,
            xValueMapper: (MapEntry<DateTime, double> entry, _) => entry.key,
            yValueMapper: (MapEntry<DateTime, double> entry, _) => entry.value,
            name: 'Value',
          ),
          LineSeries<MapEntry<DateTime, double>, DateTime>(
            dataSource: investedData,
            xValueMapper: (MapEntry<DateTime, double> entry, _) => entry.key,
            yValueMapper: (MapEntry<DateTime, double> entry, _) => entry.value,
            name: 'Invested',
          ),
        ],
        tooltipBehavior: TooltipBehavior(enable: true),
      );
    }
    return const Text('');
  }

  String _getRiskLevelName(RiskLevel riskLevel) {
    switch (riskLevel) {
      case RiskLevel.low:
        return 'Low Risk';
      case RiskLevel.medium:
        return 'Medium Risk';
      case RiskLevel.high:
        return 'High Risk';
    }
  }

  Color _getColorForRiskLevel(RiskLevel key) {
    switch (key) {
      case RiskLevel.low:
        return Colors.green;
      case RiskLevel.medium:
        return Colors.orange;
      case RiskLevel.high:
        return Colors.red;
    }
  }

  List<Color> _getColorList(Map<RiskLevel, double> value) {
    List<Color> colors = [];

    for (var element in value.keys) {
      colors.add(_getColorForRiskLevel(element));
    }

    return colors;
  }

  @override
  DashboardPresenter initializePresenter() {
    return DashboardPresenter();
  }
}