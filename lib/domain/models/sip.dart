import 'package:wealth_wave/api/apis/investment_api.dart';
import 'package:wealth_wave/api/apis/transaction_api.dart';
import 'package:wealth_wave/api/db/app_database.dart';
import 'package:wealth_wave/contract/sip_frequency.dart';
import 'package:wealth_wave/domain/models/investment.dart';
import 'package:wealth_wave/domain/models/payment.dart';
import 'package:wealth_wave/domain/models/transaction.dart';

class SIP {
  final int id;
  final int investmentId;
  final String? description;
  final double amount;
  final DateTime startDate;
  final DateTime? endDate;
  final SipFrequency frequency;
  final DateTime? executedTill;

  final TransactionApi _transactionApi;
  final InvestmentApi _investmentApi;

  SIP(
      {required this.id,
      required this.investmentId,
      required this.description,
      required this.amount,
      required this.startDate,
      required this.endDate,
      required this.frequency,
      required this.executedTill,
      final TransactionApi? transactionApi,
      final InvestmentApi? investmentApi})
      : _transactionApi = transactionApi ?? TransactionApi(),
        _investmentApi = investmentApi ?? InvestmentApi();

  Future<List<Payment>> getFuturePayment({required final DateTime till}) {
    return Future(() {
      List<Payment> payments = [];
      for (var i = startDate;
          i.isBefore(endDate ?? till);
          i = i.add(getDuration(frequency))) {
        payments.add(Payment(amount: amount, createdOn: i));
      }
      return payments;
    });
  }

  Future<List<Transaction>> getTransactions() {
    return _transactionApi.getBy(sipId: id).then((transactions) => transactions
        .map((transactionDO) => Transaction.from(transactionDO: transactionDO))
        .toList());
  }

  Future<Investment> getInvestment() {
    return _investmentApi
        .getById(id: investmentId)
        .then((investmentDO) => Investment.from(investmentDO: investmentDO));
  }

  Future<Transaction> createTransaction(
      {required final String description,
      required final double amount,
      required final DateTime createdOn}) async {
    return _transactionApi
        .create(
            investmentId: investmentId,
            sipId: id,
            description: description,
            amount: amount,
            createdOn: createdOn)
        .then((id) => _transactionApi.getById(id: id))
        .then(
            (transactionDO) => Transaction.from(transactionDO: transactionDO));
  }

  Future<Transaction> updateTransactions(
      {required final int transactionId,
      required final String description,
      required final double amount,
      required final DateTime createdOn}) async {
    return _transactionApi
        .update(
            id: transactionId,
            investmentId: investmentId,
            sipId: id,
            description: description,
            amount: amount,
            createdOn: createdOn)
        .then((count) => _transactionApi.getById(id: transactionId))
        .then(
            (transactionDO) => Transaction.from(transactionDO: transactionDO));
  }

  Future<void> deleteTransaction({required final int transactionId}) async {
    return _transactionApi.deleteBy(id: transactionId).then((count) => {});
  }

  Future<void> deleteTransactions() async {
    return _transactionApi.deleteBy(sipId: id).then((count) => {});
  }

  static SIP from({required final SipDO sipDO}) {
    return SIP(
        id: sipDO.id,
        investmentId: sipDO.investmentId,
        description: sipDO.description,
        amount: sipDO.amount,
        startDate: sipDO.startDate,
        endDate: sipDO.endDate,
        frequency: sipDO.frequency,
        executedTill: sipDO.executedTill);
  }
}
