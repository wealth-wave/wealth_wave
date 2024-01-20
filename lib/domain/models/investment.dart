import 'package:wealth_wave/api/apis/basket_api.dart';
import 'package:wealth_wave/api/apis/goal_api.dart';
import 'package:wealth_wave/api/apis/goal_investment_api.dart';
import 'package:wealth_wave/api/apis/sip_api.dart';
import 'package:wealth_wave/api/apis/transaction_api.dart';
import 'package:wealth_wave/api/db/app_database.dart';
import 'package:wealth_wave/contract/risk_level.dart';
import 'package:wealth_wave/contract/sip_frequency.dart';
import 'package:wealth_wave/domain/models/basket.dart';
import 'package:wealth_wave/domain/models/goal.dart';
import 'package:wealth_wave/domain/models/irr_calculator.dart';
import 'package:wealth_wave/domain/models/payment.dart';
import 'package:wealth_wave/domain/models/sip.dart';
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
  final GoalInvestmentApi _goalInvestmentApi;
  final GoalApi _goalApi;
  final SipApi _sipApi;

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
      final TransactionApi? transactionApi,
      final IRRCalculator? irrCalculator,
      final BasketApi? basketApi,
      final GoalInvestmentApi? goalInvestmentApi,
      final GoalApi? goalApi,
      final SipApi? sipApi})
      : _transactionApi = transactionApi ?? TransactionApi(),
        _irrCalculator = irrCalculator ?? IRRCalculator(),
        _basketApi = basketApi ?? BasketApi(),
        _goalInvestmentApi = goalInvestmentApi ?? GoalInvestmentApi(),
        _goalApi = goalApi ?? GoalApi(),
        _sipApi = sipApi ?? SipApi();

  Future<double> getTotalInvestedAmount() async {
    return _transactionApi
        .getBy(investmentId: id)
        .then((transactions) => transactions
            .map((transactionDO) =>
                Transaction.from(transactionDO: transactionDO))
            .toList())
        .then((transactions) =>
            transactions.map((transaction) => transaction.amount))
        .then((amounts) => amounts.isNotEmpty
            ? amounts.reduce((value, element) => value + element)
            : 0);
  }

  Future<double> getValueOn(
      {required final DateTime date,
      bool considerFuturePayments = false}) async {
    final payments = await getTransactions().then((transactions) => transactions
        .map((transaction) => transaction.toPayment())
        .toList(growable: true));
    if (considerFuturePayments) {
      getSips().then((sips) => Future.wait(sips.map((sip) => sip
          .getFuturePayment(till: date)
          .then((futurePayments) => payments.addAll(futurePayments)))));
    }

    final value = this.value;
    final valueUpdatedOn = this.valueUpdatedOn;
    final irr = this.irr;
    if (value != null && valueUpdatedOn != null) {
      final irr = _irrCalculator.calculateIRR(
          payments: payments, value: value, valueUpdatedOn: valueUpdatedOn);
      return _irrCalculator.calculateValueOnIRR(
          irr: irr, date: date, value: value, valueUpdatedOn: valueUpdatedOn);
    } else if (irr != null) {
      return _irrCalculator.calculateFutureValueOnIRR(
          payments: payments, irr: irr, date: date);
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

  Future<Map<Goal, double>> getGoals() async {
    return _goalInvestmentApi
        .getBy(goalId: id)
        .then((goalInvestments) => Future.wait(goalInvestments.map(
            (goalInvestment) => _goalApi
                .getBy(id: goalInvestment.goalId)
                .then((goalDO) => Goal.from(goalDO: goalDO))
                .then(
                    (goal) => MapEntry(goal, goalInvestment.splitPercentage)))))
        .then((entries) => Map.fromEntries(entries));
  }

  Future<List<SIP>> getSips() async {
    return _sipApi.getBy(investmentId: id).then(
        (sips) => Future.wait(sips.map((sipDO) => SIP.from(sipDO: sipDO))));
  }

  Future<SIP> createSip(
      {required final String? description,
      required final double amount,
      required final DateTime startDate,
      required final DateTime? endDate,
      required final SipFrequency frequency}) async {
    return _sipApi
        .create(
            investmentId: id,
            description: description,
            amount: amount,
            startDate: startDate,
            endDate: endDate,
            frequency: frequency)
        .then((id) => _sipApi.getById(id: id))
        .then((sipDO) => SIP.from(sipDO: sipDO))
        .then((sip) => sip.performSipTransactions().then((_) => sip));
  }

  Future<SIP> updateSip(
      {required final int sipId,
      required final String? description,
      required final double amount,
      required final DateTime startDate,
      required final DateTime? endDate,
      required final SipFrequency frequency}) async {
    return _sipApi
        .update(
            id: sipId,
            investmentId: id,
            description: description,
            amount: amount,
            startDate: startDate,
            endDate: endDate,
            frequency: frequency)
        .then((count) => _sipApi.getById(id: sipId))
        .then((sipDO) => SIP.from(sipDO: sipDO))
        .then((sip) => sip
            .deleteTransactions()
            .then((_) => sip.performSipTransactions().then((_) => sip)));
  }

  Future<void> deleteSIP({required final int sipId}) async {
    return _sipApi.delete(id: sipId).then((count) => {});
  }

  Future<Transaction> createTransaction(
      {required final String? description,
      required final double amount,
      required final DateTime createdOn}) async {
    return _transactionApi
        .create(
            investmentId: id,
            description: description,
            amount: amount,
            createdOn: createdOn)
        .then((id) => _transactionApi.getById(id: id))
        .then(
            (transactionDO) => Transaction.from(transactionDO: transactionDO));
  }

  Future<Transaction> updateTransaction(
      {required final int transactionId,
      required final String? description,
      required final double amount,
      required final DateTime createdOn}) async {
    return _transactionApi
        .update(
            id: transactionId,
            investmentId: id,
            description: description,
            amount: amount,
            createdOn: createdOn)
        .then((count) => _transactionApi.getById(id: transactionId))
        .then(
            (transactionDO) => Transaction.from(transactionDO: transactionDO));
  }

  Future<void> deleteTransaction({required final int id}) async {
    return _transactionApi.deleteBy(id: id).then((count) => {});
  }

  Future<void> tagGoal(
      {required final int goalId, required final double split}) async {
    return _goalInvestmentApi
        .create(goalId: goalId, investmentId: id, splitPercentage: split)
        .then((goalInvestmentDO) => {});
  }

  Future<void> updateTaggedGoal(
      {required final int id,
      required final int goalId,
      required final double split}) async {
    return _goalInvestmentApi
        .update(
            id: id, goalId: goalId, investmentId: id, splitPercentage: split)
        .then((goalInvestmentDO) => {});
  }

  Future<void> deleteTaggedGoal({required final int goalId}) {
    return _goalInvestmentApi
        .deleteBy(goalId: goalId, investmentId: id)
        .then((count) => {});
  }

  Future<double> getIRR() async {
    if (irr != null) {
      return Future(() => irr!);
    } else if (value != null && valueUpdatedOn != null) {
      List<Payment> payments = await getTransactions().then((transactions) =>
          transactions
              .map((transaction) => transaction.toPayment())
              .toList(growable: true));

      return getValueOn(date: DateTime.now()).then((valueOn) =>
          _irrCalculator.calculateIRR(
              payments: payments,
              value: value!,
              valueUpdatedOn: valueUpdatedOn!));
    } else {
      return Future.error('IRR is null');
    }
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
