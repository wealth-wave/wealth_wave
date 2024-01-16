import 'package:wealth_wave/api/apis/basket_api.dart';
import 'package:wealth_wave/api/apis/transaction_api.dart';
import 'package:wealth_wave/api/db/app_database.dart';
import 'package:wealth_wave/contract/risk_level.dart';
import 'package:wealth_wave/domain/models/basket.dart';
import 'package:wealth_wave/domain/models/irr_calculator.dart';
import 'package:wealth_wave/domain/models/transaction.dart';

class Investment {
  final int id;
  final String name;
  final String? description;
  final RiskLevel riskLevel;
  final double? value;
  final double? irr;
  final DateTime? valueUpdatedOn;
  final DateTime? maturityDate;
  final int? basketId;

  final TransactionApi _transactionApi;
  final IRRCalculator _irrCalculator;
  final BasketApi _basketApi;

  Investment(
      {required this.id,
      required this.name,
      required this.description,
      required this.riskLevel,
      required this.irr,
      required this.value,
      required this.valueUpdatedOn,
      required this.basketId,
      required this.maturityDate,
      TransactionApi? transactionApi,
      IRRCalculator? irrCalculator,
      BasketApi? basketApi})
      : _transactionApi = transactionApi ?? TransactionApi(),
        _irrCalculator = irrCalculator ?? IRRCalculator(),
        _basketApi = basketApi ?? BasketApi();

  Future<double> getTotalInvestedAmount() async {
    return _transactionApi
        .getBy(investmentId: id)
        .then((transactions) => transactions
            .map((transactionDO) =>
                Transaction.from(transactionDO: transactionDO))
            .toList())
        .then((transactions) => transactions
            .map((transaction) => transaction.amount)
            .reduce((value, element) => value + element));
  }

  Future<double> getValueOn(DateTime date) async {
    if (value != null && valueUpdatedOn != null) {
      final transactions = await getTransactions();
      final irr = _irrCalculator.calculateIRR(
          transactions: transactions,
          value: value!,
          valueUpdatedOn: valueUpdatedOn!);
      if (irr == null) {
        return value!;
      }
      return _irrCalculator.calculateValueOnIRR(
          irr: irr, date: date, value: value!, valueUpdatedOn: valueUpdatedOn!);
    } else if (irr != null) {
      final transactions = await getTransactions();
      return _irrCalculator.calculateTransactedValueOnIRR(
          transactions: transactions, irr: irr!, date: date);
    } else {
      throw Exception('Value and IRR are null');
    }
  }

  Future<List<Transaction>> getTransactions() async {
    return _transactionApi.getBy(investmentId: id).then((transactions) =>
        transactions
            .map((transactionDO) =>
                Transaction.from(transactionDO: transactionDO))
            .toList());
  }

  Future<Basket?> getBasket() async {
    if (basketId != null) {
      return _basketApi
          .getBy(id: basketId!)
          .then((basketDO) => Basket.from(basketDO: basketDO));
    }
    return null;
  }

  static Investment from({required final InvestmentDO investmentDO}) {
    return Investment(
        id: investmentDO.id,
        name: investmentDO.name,
        description: investmentDO.description,
        riskLevel: investmentDO.riskLevel,
        irr: investmentDO.irr,
        value: investmentDO.value,
        valueUpdatedOn: investmentDO.valueUpdatedOn,
        basketId: investmentDO.basketId,
        maturityDate: investmentDO.maturityDate);
  }
}
