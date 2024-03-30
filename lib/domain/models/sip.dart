import 'package:wealth_wave/api/db/app_database.dart';
import 'package:wealth_wave/contract/frequency.dart';
import 'package:wealth_wave/domain/models/payment.dart';

class Sip {
  final int id;
  final int investmentId;
  final String? description;
  final double amount;
  final DateTime startDate;
  final DateTime? endDate;
  final Frequency frequency;
  final DateTime? executedTill;

  Sip._(
      {required this.id,
      required this.investmentId,
      required this.description,
      required this.amount,
      required this.startDate,
      required this.endDate,
      required this.frequency,
      required this.executedTill});

  List<Payment> getFuturePayment({required final DateTime till}) {
    final List<Payment> payments = [];
    final DateTime? endDate = this.endDate;
    for (var i = executedTill ?? startDate;
        i.isBefore(till) && (endDate == null || i.isBefore(endDate));
        i = i.add(getDuration(frequency))) {
      payments.add(Payment.from(amount: amount, createdOn: i));
    }
    return payments;
  }

  factory Sip.from({required final SipDO sipDO}) => Sip._(
      id: sipDO.id,
      investmentId: sipDO.investmentId,
      description: sipDO.description,
      amount: sipDO.amount,
      startDate: sipDO.startDate,
      endDate: sipDO.endDate,
      frequency: sipDO.frequency,
      executedTill: sipDO.executedTill);
}
