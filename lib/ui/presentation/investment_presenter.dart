import 'package:wealth_wave/contract/risk_level.dart';
import 'package:wealth_wave/core/presenter.dart';
import 'package:wealth_wave/domain/models/investment.dart';
import 'package:wealth_wave/domain/models/sip.dart';
import 'package:wealth_wave/domain/models/transaction.dart';
import 'package:wealth_wave/domain/services/investment_service.dart';

class InvestmentPresenter extends Presenter<InvestmentViewState> {
  final InvestmentService _investmentService;

  InvestmentPresenter({final InvestmentService? investmentService})
      : _investmentService = investmentService ?? InvestmentService(),
        super(InvestmentViewState());

  void fetchInvestment({required final int id}) {
    _investmentService.getBy(id: id).then((investment) {
      return InvestmentVO.from(
          investment: investment,
          investmentOverTime: _getInvestmentOverTime(investment),
          valueOverTime: _getValueOverTime(investment));
    }).then((investmentVO) {
      updateViewState((viewState) {
        viewState.investmentVO = investmentVO;
      });
    });
  }

  Map<DateTime, double> _getInvestmentOverTime(Investment investment) {
    Map<DateTime, double> valueOverTime = {};
    Map<DateTime, double> dateInvestmentMap = {};

    investment
        .getPayments(till: DateTime.now())
        .map((e) => MapEntry(e.createdOn, e.amount))
        .forEach((entry) {
      dateInvestmentMap.update(entry.key, (value) => value + entry.value,
          ifAbsent: () => entry.value);
    });
    dateInvestmentMap.update(DateTime.now(), (value) => value,ifAbsent: () => 0);
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

  Map<DateTime, double> _getValueOverTime(Investment investment) {
    Map<DateTime, double> valueOverTime = {};
    Map<DateTime, double> dateInvestmentMap = {};
    double totalValue = 0;
    double totalInvested = 0;

    investment
        .getPayments(till: DateTime.now())
        .map((e) => MapEntry(e.createdOn, e.amount))
        .forEach((entry) {
      dateInvestmentMap.update(entry.key, (value) => value + entry.value,
          ifAbsent: () => entry.value);
    });
    dateInvestmentMap.update(DateTime.now(), (value) => value,ifAbsent: () => 0);
    totalValue += investment.getValueOn(date: DateTime.now());
    totalInvested += investment.getTotalInvestedAmount(till: DateTime.now());

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

class InvestmentViewState {
  InvestmentVO? investmentVO;
}

class InvestmentVO {
  final int id;
  final String name;
  final String? description;
  final RiskLevel riskLevel;
  final double irr;
  final double investedValue;
  final double currentValue;
  final double qty;
  final DateTime? maturityDate;
  final int? basketId;
  final String? basketName;
  final List<Sip> sips;
  final List<Transaction> transactions;
  final bool hasScript;
  final Map<DateTime, double> investmentOverTime;
  final Map<DateTime, double> valueOverTime;

  int get transactionCount => transactions.length;
  int get sipCount => sips.length;

  InvestmentVO._(
      {required this.id,
      required this.name,
      required this.description,
      required this.riskLevel,
      required this.irr,
      required this.basketId,
      required this.basketName,
      required this.investedValue,
      required this.currentValue,
      required this.qty,
      required this.maturityDate,
      required this.transactions,
      required this.sips,
      required this.hasScript,
      required this.investmentOverTime,
      required this.valueOverTime});

  factory InvestmentVO.from(
      {required final Investment investment,
      required final Map<DateTime, double> investmentOverTime,
      required final Map<DateTime, double> valueOverTime}) {
    return InvestmentVO._(
        id: investment.id,
        name: investment.name,
        description: investment.description,
        riskLevel: investment.riskLevel,
        irr: investment.getIRR(),
        investedValue: investment.getTotalInvestedAmount(),
        currentValue: investment.getValue(),
        qty: investment.qty,
        basketId: investment.basketId,
        basketName: investment.basketName,
        transactions: investment.transactions,
        sips: investment.sips,
        hasScript: investment.script != null,
        maturityDate: investment.maturityDate,
        investmentOverTime: investmentOverTime,
        valueOverTime: valueOverTime);
  }
}
