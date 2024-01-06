import 'package:wealth_wave/api/db/app_database.dart';

class SIP {
  final int id;
  final String? description;
  final double amount;
  final DateTime startDate;
  final DateTime endDate;
  final double frequency;

  SIP(
      {required this.id,
      required this.description,
      required this.amount,
      required this.startDate,
      required this.endDate,
      required this.frequency});

  static SIP from({required final SipDO sip}) {
    return SIP(
        id: sip.id,
        description: sip.description,
        amount: sip.amount,
        startDate: sip.startDate,
        endDate: sip.endDate,
        frequency: sip.frequency);
  }
}
