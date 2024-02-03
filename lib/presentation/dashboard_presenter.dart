import 'package:wealth_wave/contract/risk_level.dart';
import 'package:wealth_wave/core/presenter.dart';
import 'package:wealth_wave/domain/models/investment.dart';
import 'package:wealth_wave/domain/services/investment_service.dart';

class DashboardPresenter extends Presenter<DashboardViewState> {
  final InvestmentService _investmentService;

  DashboardPresenter({final InvestmentService? investmentService})
      : _investmentService = investmentService ?? InvestmentService(),
        super(DashboardViewState());

  void fetchDashboard() {
    _investmentService.get().then((investments) {
      double totalInvestedAmount = 0;
      double totalValueOfInvestment = 0;
      Map<RiskLevel, double> riskComposition = {};
      Map<String, double> basketComposition = {};
      Map<double, double> irrComposition = {};

      for (var investment in investments) {
        double investmentValue = investment.getValueOn(date: DateTime.now());
        double investedAmount =
            investment.getTotalInvestedAmount(till: DateTime.now());
        totalInvestedAmount += investedAmount;
        totalValueOfInvestment += investmentValue;
        riskComposition.update(
            investment.riskLevel, (value) => value + investmentValue,
            ifAbsent: () => investmentValue);
        basketComposition.update(
            investment.basketName ?? '-', (value) => value + investmentValue,
            ifAbsent: () => investmentValue);
        irrComposition.update((investment.getIRR()).roundToDouble(),
            (value) => value + (investmentValue - investedAmount),
            ifAbsent: () => (investmentValue - investedAmount));
      }
      irrComposition.removeWhere((key, value) => value == 0);

      updateViewState((viewState) {
        viewState.invested = totalInvestedAmount;
        viewState.currentValue = totalValueOfInvestment;
        viewState.riskComposition = riskComposition
            .map((key, value) => MapEntry(key, value / totalValueOfInvestment));
        viewState.basketComposition = basketComposition
            .map((key, value) => MapEntry(key, value / totalValueOfInvestment));
        viewState.irrComposition = irrComposition;
        viewState.valueOverTime = _getValueOverTime(investments);
        viewState.investmentOverTime = _getInvestmentOverTime(investments);
      });
    });
  }

  Map<DateTime, double> _getInvestmentOverTime(List<Investment> investments) {
    Map<DateTime, double> valueOverTime = {};
    Map<DateTime, double> dateInvestmentMap = {};

    for (var investment in investments) {
      investment
          .getPayments(till: DateTime.now())
          .map((e) => MapEntry(e.createdOn, e.amount))
          .forEach((entry) {
        dateInvestmentMap.update(entry.key, (value) => value + entry.value,
            ifAbsent: () => entry.value);
      });
    }
    List<DateTime> investmentDates = dateInvestmentMap.keys.toList();
    investmentDates.sort((a, b) => a.compareTo(b));

    double previousValue = 0;
    for (var date in investmentDates) {
      double investedAmount = dateInvestmentMap[date] ?? 0;
      double valueSoFar = previousValue + investedAmount;
      valueOverTime[date] = valueSoFar;
      previousValue = valueSoFar;
    }

    return valueOverTime;
  }

  Map<DateTime, double> _getValueOverTime(List<Investment> investments) {
    Map<DateTime, double> valueOverTime = {};
    Map<DateTime, double> dateInvestmentMap = {};
    double totalValue = 0;
    double totalInvested = 0;

    for (var investment in investments) {
      investment.getPayments(till: DateTime.now())
          .map((e) => MapEntry(e.createdOn, e.amount))
          .forEach((entry) {
        dateInvestmentMap.update(entry.key, (value) => value + entry.value,
            ifAbsent: () => entry.value);
      });
      totalValue += investment.getValueOn(date: DateTime.now());
      totalInvested += investment.getTotalInvestedAmount(till: DateTime.now());
    }

    List<DateTime> investmentDates = dateInvestmentMap.keys.toList();
    investmentDates.sort((a, b) => a.compareTo(b));

    double previousValue = 0;
    for (var date in investmentDates) {
      double proportion = (dateInvestmentMap[date] ?? 0) / totalInvested;
      double value = (proportion * totalValue);
      double valueSoFar = previousValue + value;
      valueOverTime[date] = valueSoFar;
      previousValue = valueSoFar;
    }

    return valueOverTime;
  }
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
