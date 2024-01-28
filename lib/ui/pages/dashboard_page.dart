import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:primer_progress_bar/primer_progress_bar.dart';
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
    return SizedBox(
        height: 200,
        child: PieChart(PieChartData(
            sections: data.entries
                .map((e) => PieChartSectionData(
                      value: e.value,
                      color: _getColorForRiskLevel(e.key),
                      title: _getRiskLevelName(e.key),
                    ))
                .toList())));
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
    List<FlSpot> valueDataSpots = valueData
        .map((data) =>
            FlSpot(data.key.millisecondsSinceEpoch.toDouble(), data.value))
        .toList();

    List<FlSpot> investedDataSpots = investedData
        .map((data) =>
            FlSpot(data.key.millisecondsSinceEpoch.toDouble(), data.value))
        .toList();

    return LineChart(
      LineChartData(
        gridData: const FlGridData(
          show: true,
        ),
        titlesData: FlTitlesData(
          bottomTitles: AxisTitles(
              sideTitles: SideTitles(
            showTitles: true,
            getTitlesWidget: (value, m) => Text(
                DateTime.fromMillisecondsSinceEpoch(value.toInt())
                    .year
                    .toString()),
          )),
          leftTitles: AxisTitles(
              sideTitles: SideTitles(
            showTitles: true,
            getTitlesWidget: (value, m) => Text(formatToCurrency(value)),
          )),
        ),
        borderData: FlBorderData(
          show: false,
        ),
        lineBarsData: [
          LineChartBarData(
            spots: valueDataSpots,
            isCurved: true,
            color: Colors.blue,
            dotData: FlDotData(show: false),
          ),
          LineChartBarData(
            spots: investedDataSpots,
            isCurved: true,
            color: Colors.red,
            dotData: FlDotData(show: false),
          ),
        ],
      ),
    );
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

  @override
  DashboardPresenter initializePresenter() {
    return DashboardPresenter();
  }
}
