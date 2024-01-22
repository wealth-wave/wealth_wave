import 'package:wealth_wave/contract/risk_level.dart';
import 'package:wealth_wave/core/presenter.dart';
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
        .then((investments) => investments
            .map((investment) => InvestmentVO.from(investment: investment))
            .toList())
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
  final int? basketId;
  final String? basketName;
  final List<Sip> sips;
  final List<Transaction> transactions;
  final int taggedGoalCount;

  int get transactionCount => transactions.length;

  int get sipCount => sips.length;

  InvestmentVO(
      {required this.id,
      required this.name,
      required this.description,
      required this.riskLevel,
      required this.irr,
      required this.value,
      required this.valueUpdatedOn,
      required this.basketId,
      required this.basketName,
      required this.investedValue,
      required this.currentValue,
      required this.maturityDate,
      required this.transactions,
      required this.sips,
      required this.taggedGoalCount});

  factory InvestmentVO.from({required final Investment investment}) {
    return InvestmentVO(
        id: investment.id,
        name: investment.name,
        description: investment.description,
        riskLevel: investment.riskLevel,
        irr: investment.getIRR(),
        value: investment.value,
        investedValue: investment.getTotalInvestedAmount(),
        currentValue: investment.getValueOn(date: DateTime.now()),
        valueUpdatedOn: investment.valueUpdatedOn,
        basketId: investment.basketId,
        basketName: investment.basketName,
        transactions: investment.transactions,
        sips: investment.sips,
        taggedGoalCount: investment.goalsCount,
        maturityDate: investment.maturityDate);
  }
}
