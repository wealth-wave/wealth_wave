

class SIP {
  final int id;
  final String? description;
  final double amount;
  final DateTime startDate;
  final DateTime endDate;
  final double frequency;
  final DateTime? executedTill;

  SIP(
      {required this.id,
      required this.description,
      required this.amount,
      required this.startDate,
      required this.endDate,
      required this.frequency,
      required this.executedTill});
}
