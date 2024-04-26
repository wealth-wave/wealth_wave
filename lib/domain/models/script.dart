import 'package:wealth_wave/api/db/app_database.dart';

class Script {
  final int id;
  final int investmentId;
  final String dsl;

  Script({required this.dsl, required this.id, required this.investmentId});

  double getValue() {
    return 0.0;
  }

  factory Script.from({required final ScriptDO scriptDO}) => Script(
      id: scriptDO.id,
      investmentId: scriptDO.investmentId,
      dsl: scriptDO.script);
}
