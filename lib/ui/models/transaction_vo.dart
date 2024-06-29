import 'package:wealth_wave/domain/models/transaction.dart';

class TransactionVO {
  final int id;
  final int investmentId;
  final int? sipId;
  final String? description;
  final double amount;
  final DateTime createdOn;

  TransactionVO._(
      {required this.id,
      required this.investmentId,
      required this.sipId,
      required this.description,
      required this.amount,
      required this.createdOn});

  factory TransactionVO.from({required final Transaction transaction}) {
    return TransactionVO._(
        id: transaction.id,
        investmentId: transaction.investmentId,
        sipId: transaction.sipId,
        description: transaction.description,
        amount: transaction.amount,
        createdOn: transaction.createdOn);
  }
}
