import 'package:wealth_wave/api/db/app_database.dart';
import 'package:wealth_wave/domain/models/payment.dart';

class Transaction {
  final int id;
  final int investmentId;
  final int? sipId;
  final String? description;
  final double amount;
  final DateTime createdOn;

  Transaction._(
      {required this.id,
      required this.investmentId,
      required this.sipId,
      required this.description,
      required this.amount,
      required this.createdOn});

  Payment toPayment() => Payment.from(amount: amount, createdOn: createdOn);

  factory Transaction.from({required final TransactionDO transactionDO}) =>
      Transaction._(
          id: transactionDO.id,
          investmentId: transactionDO.investmentId,
          sipId: transactionDO.sipId,
          description: transactionDO.description,
          amount: transactionDO.amount,
          createdOn: transactionDO.createdOn);
}
