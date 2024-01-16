import 'package:wealth_wave/api/apis/transaction_api.dart';
import 'package:wealth_wave/api/db/app_database.dart';
import 'package:wealth_wave/contract/sip_frequency.dart';
import 'package:wealth_wave/domain/models/payment.dart';
import 'package:wealth_wave/domain/models/transaction.dart';

class SIP {
  final int id;
  final String? description;
  final double amount;
  final DateTime startDate;
  final DateTime? endDate;
  final SipFrequency frequency;
  final DateTime? executedTill;

  final TransactionApi _transactionApi;

  SIP(
      {required this.id,
      required this.description,
      required this.amount,
      required this.startDate,
      required this.endDate,
      required this.frequency,
      required this.executedTill,
      final TransactionApi? transactionApi})
      : _transactionApi = transactionApi ?? TransactionApi();

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

  static SIP from({required final SipDO sipDO}) {
    return SIP(
        id: sipDO.id,
        description: sipDO.description,
        amount: sipDO.amount,
        startDate: sipDO.startDate,
        endDate: sipDO.endDate,
        frequency: sipDO.frequency,
        executedTill: sipDO.executedTill);
  }
}
