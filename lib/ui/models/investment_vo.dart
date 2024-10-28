import 'package:wealth_wave/contract/risk_level.dart';
import 'package:wealth_wave/domain/models/investment.dart';
import 'package:wealth_wave/ui/models/sip_vo.dart';
import 'package:wealth_wave/ui/models/transaction_vo.dart';

class InvestmentVO {
  final int id;
  final String name;
  final String? description;
  final RiskLevel riskLevel;
  final double irr;
  final double investedValue;
  final double currentValue;
  final DateTime? valueUpdatedDate;
  final double qty;
  final bool inActive;
  final double valuePerQty;
  final DateTime? maturityDate;
  final int? basketId;
  final String? basketName;
  final List<SipVO> sips;
  final List<TransactionVO> transactions;
  final bool hasScript;

  int get transactionCount => transactions.length;
  int get sipCount => sips.length;
  String get valueUpdateDate => valueUpdatedDate?.toIso8601String() ?? 'Not Updated';
  bool get isProfit => currentValue > investedValue;
  double get profit => currentValue - investedValue;

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
      required this.valueUpdatedDate,
      required this.qty,
      required this.inActive,
      required this.valuePerQty,
      required this.maturityDate,
      required this.transactions,
      required this.sips,
      required this.hasScript});

  factory InvestmentVO.from({required final Investment investment}) {
    return InvestmentVO._(
        id: investment.id,
        name: investment.name,
        description: investment.description,
        riskLevel: investment.riskLevel,
        irr: investment.getIRR(),
        investedValue: investment.getTotalInvestedAmount(),
        currentValue: investment.getValue(),
        valueUpdatedDate: investment.valueUpdatedOn,
        inActive: investment.inActive(),
        qty: investment.qty ?? 1,
        valuePerQty: investment.getValuePerUnit(),
        basketId: investment.basketId,
        basketName: investment.basketName,
        transactions: investment.transactions.map((e) => TransactionVO.from(transaction: e)).toList(),
        sips: investment.sips.map((e) => SipVO.from(transaction: e)).toList(),
        hasScript: investment.script != null,
        maturityDate: investment.maturityDate);
  }
}