import 'package:wealth_wave/contract/risk_level.dart';

class Investment {
  final int id;
  final String name;
  final double value;
  final RiskLevel riskLevel;
  final DateTime valueUpdatedOn;

  Investment(
      {required this.id,
      required this.name,
      required this.value,
      required this.riskLevel,
      required this.valueUpdatedOn});
}
