import 'dart:math';

import 'package:wealth_wave/contract/risk_level.dart';
import 'package:wealth_wave/core/presenter.dart';
import 'package:wealth_wave/domain/models/investment.dart';
import 'package:wealth_wave/domain/models/transaction.dart';
import 'package:wealth_wave/domain/services/investment_service.dart';

class DashboardPresenter extends Presenter<DashboardViewState> {
  final InvestmentService _investmentService;

  DashboardPresenter({final InvestmentService? investmentService})
      : _investmentService = investmentService ?? InvestmentService(),
        super(DashboardViewState());

  void fetchDashboard() {
    _investmentService.get().then((investments) {
      double invested = 0;
      double currentValue = 0;
      Map<RiskLevel, double> riskComposition = {};
      Map<String, double> basketComposition = {};
      Map<double, double> irrComposition = {};

      for (var investment in investments) {
        double investmentValue = investment.getValueOn(date: DateTime.now());
        invested += investment.getTotalInvestedAmount(till: DateTime.now());
        currentValue += investmentValue;
        riskComposition.update(
            investment.riskLevel, (value) => value + investmentValue,
            ifAbsent: () => investmentValue);
        basketComposition.update(
            investment.basketName ?? '-', (value) => value + investmentValue,
            ifAbsent: () => investmentValue);
        irrComposition.update((investment.getIRR()).roundToDouble(),
            (value) => value + investmentValue,
            ifAbsent: () => investmentValue);
      }

      updateViewState((viewState) {
        viewState.invested = invested;
        viewState.currentValue = currentValue;
        viewState.riskComposition = riskComposition
            .map((key, value) => MapEntry(key, value / currentValue));
        viewState.basketComposition = basketComposition
            .map((key, value) => MapEntry(key, value / currentValue));
        viewState.irrComposition = irrComposition
            .map((key, value) => MapEntry(key, value / currentValue));
        viewState.valueOverTime = _getValueOverTime(investments);
        viewState.investmentOverTime = _getInvestmentOverTime(investments);
      });
    });
  }
}

Map<DateTime, double> _getInvestmentOverTime(List<Investment> investments) {
  Map<DateTime, double> valueOverTime = {};
  List<Transaction> transactions = [];

  for (var investment in investments) {
    transactions.addAll(investment.transactions);
  }
  transactions.sort((a, b) => a.createdOn.compareTo(b.createdOn));

  double previousValue = 0;
  DateTime previousDate = transactions.firstOrNull?.createdOn ?? DateTime.now();
  for (var transaction in transactions) {
    double valueAtTransactionDate = previousValue + transaction.amount;
    valueOverTime[transaction.createdOn] =
        (valueOverTime[transaction.createdOn] ?? 0) + valueAtTransactionDate;

    valueOverTime[previousDate] =
        (valueOverTime[previousDate] ?? 0) + transaction.amount;

    previousValue = transaction.amount;
    previousDate = transaction.createdOn;
  }

  return valueOverTime;
}

Map<DateTime, double> _getValueOverTime(List<Investment> investments) {
  Map<DateTime, double> valueOverTime = {};

  List<Transaction> transactions = [];
  Map<double, double> irrComposition = {};
  for (var investment in investments) {
    transactions.addAll(investment.transactions);
    double valueOfInvestment = investment.getValueOn(date: DateTime.now());
    irrComposition.update((investment.getIRR()).roundToDouble(),
        (value) => value + valueOfInvestment,
        ifAbsent: () => valueOfInvestment);
  }
  double totalValue = irrComposition.values.fold(0, (a, b) => a + b);
  irrComposition =
      irrComposition.map((key, value) => MapEntry(key, value / totalValue));
  double averageIRR = irrComposition.entries
      .map((e) => e.key * e.value)
      .toList()
      .fold(0, (a, b) => a + b);

  transactions.sort((a, b) => a.createdOn.compareTo(b.createdOn));

  double previousValue = 0;
  DateTime previousDate = transactions.firstOrNull?.createdOn ?? DateTime.now();
  for (var transaction in transactions) {
    // Calculate the value of the investment at the date of the transaction
    double valueAtTransactionDate = previousValue + transaction.amount;
    valueOverTime[transaction.createdOn] =
        (valueOverTime[transaction.createdOn] ?? 0) + valueAtTransactionDate;

    // Calculate the value of the investment at the current date
    int days = previousDate.difference(transaction.createdOn).inDays;
    double valueAtCurrentDate =
        valueAtTransactionDate * pow(1 + averageIRR, days / 365);
    valueOverTime[previousDate] =
        (valueOverTime[previousDate] ?? 0) + valueAtCurrentDate;

    previousValue = valueAtCurrentDate;
    previousDate = transaction.createdOn;
  }

  return valueOverTime;
}

class DashboardViewState {
  double invested = 0;
  double currentValue = 0;
  Map<RiskLevel, double> riskComposition = {};
  Map<String, double> basketComposition = {};
  Map<double, double> irrComposition = {};
  Map<DateTime, double> investmentOverTime = {};
  Map<DateTime, double> valueOverTime = {};
}
