import 'package:wealth_wave/contract/risk_level.dart';
import 'package:wealth_wave/core/presenter.dart';
import 'package:wealth_wave/domain/models/basket.dart';
import 'package:wealth_wave/domain/models/goal.dart';
import 'package:wealth_wave/domain/models/investment.dart';
import 'package:wealth_wave/domain/models/sip.dart';
import 'package:wealth_wave/domain/models/transaction.dart';
import 'package:wealth_wave/domain/services/investment_service.dart';

class InvestmentsPresenter extends Presenter<InvestmentsViewState> {
  final InvestmentService _investmentService;

  InvestmentsPresenter({final InvestmentService? investmentService})
      : _investmentService = investmentService ?? InvestmentService(),
        super(InvestmentsViewState());

  void fetchInvestments() {
    _investmentService
        .get()
        .then((investments) => Future.wait(investments
            .map((investment) => InvestmentVO.from(investment: investment))))
        .then((investmentVOs) => updateViewState((viewState) {
              viewState.investmentVOs = investmentVOs;
            }));
  }

  void deleteInvestment({required final int id}) {
    _investmentService.deleteBy(id: id).then((value) => fetchInvestments());
  }
}

class InvestmentsViewState {
  List<InvestmentVO> investmentVOs = [];
}

class InvestmentVO {
  final int id;
  final String name;
  final String? description;
  final RiskLevel riskLevel;
  final double? value;
  final double irr;
  final double investedValue;
  final double currentValue;
  final DateTime? valueUpdatedOn;
  final DateTime? maturityDate;
  final Basket? basket;
  final List<SIP> sips;
  final List<Transaction> transactions;
  final Map<Goal, double> goals;

  String? get basketName => basket?.name;
  int get transactionCount => transactions.length;
  int get sipCount => sips.length;
  int get goalCount => goals.length;

  InvestmentVO(
      {required this.id,
      required this.name,
      required this.description,
      required this.riskLevel,
      required this.irr,
      required this.value,
      required this.valueUpdatedOn,
      required this.basket,
      required this.investedValue,
      required this.currentValue,
      required this.maturityDate,
      required this.transactions,
      required this.sips,
      required this.goals});

  static Future<InvestmentVO> from(
      {required final Investment investment}) async {
    return InvestmentVO(
        id: investment.id,
        name: investment.name,
        description: investment.description,
        riskLevel: investment.riskLevel,
        irr: await investment.getIRR(),
        value: investment.value,
        investedValue: await investment.getTotalInvestedAmount(),
        currentValue: await investment.getValueOn(date: DateTime.now()),
        valueUpdatedOn: investment.valueUpdatedOn,
        basket: await investment.getBasket(),
        transactions: await investment.getTransactions(),
        sips: await investment.getSips(),
        goals: await investment.getGoals(),
        maturityDate: investment.maturityDate);
  }
}
