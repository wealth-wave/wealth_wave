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
    DateTime nextPaymentDate = _getInitialPaymentDate();

    while (_shouldAddPayment(nextPaymentDate, till)) {
      payments.add(Payment.from(amount: amount, createdOn: nextPaymentDate));
      nextPaymentDate = _getNextOccurrenceDateTime(nextPaymentDate, frequency);
    }
    return payments;
  }

  Payment? getNextPayment() {
    DateTime nextPaymentDate = _getInitialPaymentDate();

    if (_shouldAddPayment(nextPaymentDate, endDate)) {
      return Payment.from(amount: amount, createdOn: nextPaymentDate);
    }

    return null;
  }

  DateTime _getInitialPaymentDate() {
    return executedTill != null
        ? _getNextOccurrenceDateTime(executedTill!, frequency)
        : startDate;
  }

  bool _shouldAddPayment(DateTime nextPaymentDate, DateTime? till) {
    return nextPaymentDate.compareTo(till ?? DateTime.now()) <= 0 &&
        (endDate == null || nextPaymentDate.compareTo(endDate!) < 0);
  }

  DateTime _getNextOccurrenceDateTime(DateTime dateTime, Frequency frequency) {
    switch (frequency) {
      case Frequency.daily:
        return DateTime.utc(dateTime.year, dateTime.month, dateTime.day + 1);
      case Frequency.weekly:
        return DateTime.utc(dateTime.year, dateTime.month, dateTime.day + 7);
      case Frequency.biweekly:
        return DateTime.utc(dateTime.year, dateTime.month, dateTime.day + 14);
      case Frequency.monthly:
        return DateTime.utc(dateTime.year, dateTime.month + 1, dateTime.day);
      case Frequency.quarterly:
        return DateTime.utc(dateTime.year, dateTime.month + 3, dateTime.day);
      case Frequency.halfYearly:
        return DateTime.utc(dateTime.year, dateTime.month + 6, dateTime.day);
      case Frequency.yearly:
        return DateTime.utc(
            dateTime.year + 1, dateTime.month + 6, dateTime.day);
      default:
        throw Exception('Invalid frequency');
    }
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
