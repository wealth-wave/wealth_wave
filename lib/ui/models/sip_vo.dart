import 'package:wealth_wave/contract/frequency.dart';
import 'package:wealth_wave/domain/models/sip.dart';

class SipVO {
  final int id;
  final int investmentId;
  final String? description;
  final double amount;
  final DateTime startDate;
  final DateTime? endDate;
  final Frequency frequency;
  final DateTime? executedTill;

  SipVO._(
      {required this.id,
      required this.investmentId,
      required this.description,
      required this.amount,
      required this.startDate,
      required this.endDate,
      required this.frequency,
      required this.executedTill});

  factory SipVO.from({required final Sip transaction}) {
    return SipVO._(
        id: transaction.id,
        investmentId: transaction.investmentId,
        description: transaction.description,
        amount: transaction.amount,
        startDate: transaction.startDate,
        endDate: transaction.endDate,
        frequency: transaction.frequency,
        executedTill: transaction.executedTill);
  }
}
