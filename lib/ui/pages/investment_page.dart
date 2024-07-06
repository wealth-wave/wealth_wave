import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:wealth_wave/contract/risk_level.dart';
import 'package:wealth_wave/core/page_state.dart';
import 'package:wealth_wave/ui/presentation/investment_presenter.dart';
import 'package:wealth_wave/ui/app_dimen.dart';
import 'package:wealth_wave/utils/ui_utils.dart';

class InvestmentPage extends StatefulWidget {
  final int investmentId;

  const InvestmentPage({super.key, required this.investmentId});

  @override
  State<InvestmentPage> createState() => _InvestmentPage();
}

class _InvestmentPage extends PageState<InvestmentViewState, InvestmentPage,
    InvestmentPresenter> {
  @override
  void initState() {
    super.initState();
    presenter.fetchInvestment(id: widget.investmentId);
  }

  @override
  Widget buildWidget(
      final BuildContext context, final InvestmentViewState snapshot) {
    InvestmentVO? investmentVO = snapshot.investmentVO;
    return Scaffold(
        appBar: AppBar(
          title: const Text('Investment'),
        ),
        body: SingleChildScrollView(
            child: _investmentWidget(
                context: context, investmentVO: investmentVO)));
  }

  @override
  InvestmentPresenter initializePresenter() {
    return InvestmentPresenter();
  }

  Widget _investmentWidget(
      {required final BuildContext context,
      required final InvestmentVO? investmentVO}) {
    if (investmentVO == null) {
      return const CircularProgressIndicator();
    }

    return Column(children: [
      Card(
        margin: const EdgeInsets.all(AppDimen.defaultPadding),
        child: Padding(
          padding: const EdgeInsets.all(AppDimen.defaultPadding),
          child:
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [_getTitleWidget(investmentVO, context)]),
            OverflowBar(
              children: [
                _getInvestedWidget(investmentVO, context),
                const Padding(padding: EdgeInsets.all(AppDimen.defaultPadding)),
                _getValueWidget(investmentVO, context),
                const Padding(padding: EdgeInsets.all(AppDimen.defaultPadding)),
              ],
            )
          ]),
        ),
      ),
      _buildTimeLine(investmentVO.valueOverTime.entries.toList(),
          investmentVO.investmentOverTime.entries.toList())
    ]);
  }

  Column _getInvestedWidget(InvestmentVO investmentVO, BuildContext context) {
    return Column(
      children: [
        Text(formatToCurrency(investmentVO.investedValue),
            style: Theme.of(context).textTheme.bodyLarge),
        Text('(Invested)', style: Theme.of(context).textTheme.labelMedium),
      ],
    );
  }

  Column _getValueWidget(InvestmentVO investmentVO, BuildContext context) {
    Color color = Colors.red;
    if (investmentVO.currentValue > investmentVO.investedValue) {
      color = Colors.green;
    }
    return Column(
      children: [
        Text(formatToCurrency(investmentVO.currentValue),
            style:
                Theme.of(context).textTheme.bodyLarge!.copyWith(color: color)),
        Text('(At ${formatToPercentage(investmentVO.irr)})',
            style: Theme.of(context)
                .textTheme
                .labelMedium!
                .copyWith(color: color)),
      ],
    );
  }

  RichText _getTitleWidget(InvestmentVO investmentVO, BuildContext context) {
    List<WidgetSpan> widgets = [];
    String? basketName = investmentVO.basketName;
    if (basketName != null) {
      widgets.add(WidgetSpan(
          child: Text(' | $basketName',
              style: Theme.of(context).textTheme.labelMedium)));
    }
    widgets.add(WidgetSpan(
        child: Text(' | ${_getRiskLevel(investmentVO.riskLevel)}',
            style: Theme.of(context).textTheme.labelMedium)));
    return RichText(
        text: TextSpan(
            text: investmentVO.name,
            style: Theme.of(context).textTheme.titleMedium,
            children: widgets));
  }

  String _getRiskLevel(RiskLevel riskLevel) {
    switch (riskLevel) {
      case RiskLevel.veryLow:
        return 'Very Low';
      case RiskLevel.low:
        return 'Low';
      case RiskLevel.medium:
        return 'Medium';
      case RiskLevel.high:
        return 'High';
      case RiskLevel.veryHigh:
        return 'Very High';
    }
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
}
