import 'package:wealth_wave/contract/risk_level.dart';
import 'package:wealth_wave/core/presenter.dart';
import 'package:wealth_wave/domain/models/investment.dart';
import 'package:wealth_wave/domain/models/irr_calculator.dart';
import 'package:wealth_wave/domain/models/payment.dart';
import 'package:wealth_wave/domain/services/investment_service.dart';

class DashboardPresenter extends Presenter<DashboardViewState> {
  final InvestmentService _investmentService;
  final IRRCalculator _irrCalculator;

  DashboardPresenter(
      {final InvestmentService? investmentService,
      final IRRCalculator? irrCalculator})
      : _investmentService = investmentService ?? InvestmentService(),
        _irrCalculator = irrCalculator ?? IRRCalculator(),
        super(DashboardViewState());

  void fetchDashboard() {
    _investmentService.get().then((investments) {
      double totalInvestedAmount = 0;
      double totalValueOfInvestment = 0;
      Map<RiskLevel, double> riskComposition = {};
      Map<String, double> basketComposition = {};
      Map<int, double> irrComposition = {};
      List<Payment> payments = [];

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
        irrComposition.update(_getIrrCompositionKey(investment.getIRR()),
            (value) => value + (investmentValue - investedAmount),
            ifAbsent: () => (investmentValue - investedAmount));
        payments.addAll(investment.getPayments(till: DateTime.now()));
      }
      irrComposition.removeWhere((key, value) => value == 0);
      final overallIRR = _irrCalculator.calculateIRR(
          payments: payments,
          value: totalValueOfInvestment,
          valueUpdatedOn: DateTime.now());
      final basketIrr = _calculateBasketIRR(investments);

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
        viewState.overallIRR = overallIRR;
        viewState.basketIrr = basketIrr;
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
      investment
          .getPayments(till: DateTime.now())
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

  Map<String, double> _calculateBasketIRR(List<Investment> investments) {
    Map<String, List<Payment>> basketPayments = {};
    Map<String, double> basketValues = {};
    Map<String, double> basketIRR = {};

    for (var investment in investments) {
      String basketName = investment.basketName ?? '-';
      double investmentValue = investment.getValueOn(date: DateTime.now());

      if (!basketPayments.containsKey(basketName)) {
        basketPayments[basketName] = [];
        basketValues[basketName] = 0;
      }

      final payments = investment.getPayments(till: DateTime.now());
      basketPayments.update(basketName, (value) {
        final existingPayments = List.of(value, growable: true);
        existingPayments.addAll(payments);
        return existingPayments;
      }, ifAbsent: () => payments);
      basketValues.update(basketName, (value) => value + investmentValue,
          ifAbsent: () => investmentValue);
    }

    basketPayments.forEach((basketName, payments) {
      double totalValue = basketValues[basketName] ?? 0;
      double irr = _irrCalculator.calculateIRR(
          payments: payments, value: totalValue, valueUpdatedOn: DateTime.now());
      basketIRR[basketName] = irr;
    });

    return basketIRR;
  }
}

int _getIrrCompositionKey(double irr) {
  if (irr < 5) {
    return 5;
  } else if (irr < 10) {
    return 10;
  } else if (irr < 15) {
    return 15;
  } else if (irr < 20) {
    return 20;
  } else if (irr < 40) {
    return 40;
  } else {
    return 100;
  }
}

class DashboardViewState {
  double invested = 0;
  double currentValue = 0;
  double overallIRR = 0;
  Map<RiskLevel, double> riskComposition = {};
  Map<String, double> basketComposition = {};
  Map<String, double> basketIrr = {};
  Map<int, double> irrComposition = {};
  Map<DateTime, double> investmentOverTime = {};
  Map<DateTime, double> valueOverTime = {};
}
