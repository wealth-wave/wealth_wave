import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:wealth_wave/api/apis/script_api.dart';
import 'package:wealth_wave/domain/models/script.dart';
import 'package:wealth_wave/domain/services/dsl_parser_definition.dart';

class ScriptService {
  final ScriptApi _scriptApi;
  final DSLParserDefinition _dslParserDefinition;

  factory ScriptService() {
    return _instance;
  }

  static final ScriptService _instance = ScriptService._();

  ScriptService._(
      {final ScriptApi? scriptApi,
      final DSLParserDefinition? dslParserDefinition})
      : _scriptApi = scriptApi ?? ScriptApi(),
        _dslParserDefinition = dslParserDefinition ?? DSLParserDefinition();

  Future<Script> createScript(
          {required final int investmentId, required final String script}) =>
      _scriptApi.deleteBy(investmentId: investmentId).then((_) {
        return _scriptApi
            .create(investmentId: investmentId, script: script)
            .then((id) => _scriptApi.getById(id: id))
            .then((scriptDO) => Script.from(scriptDO: scriptDO));
      });

  Future<Script> getById({required final int id}) =>
      _scriptApi.getById(id: id).then((scriptDO) {
        return Script.from(scriptDO: scriptDO);
      });

  Future<Script> getBy({required final int investmentId}) =>
      _scriptApi.getBy(investmentId: investmentId).then((scriptDO) {
        return Script.from(scriptDO: scriptDO);
      });

  Future<List<Script>> getAll() => _scriptApi.getAll().then((scripts) =>
      scripts.map((scriptDO) => Script.from(scriptDO: scriptDO)).toList());

  Future<Script> updateScript(
          {required final int sipId,
          required final int investmentId,
          required final String script}) =>
      _scriptApi
          .update(id: sipId, investmentId: investmentId, script: script)
          .then((count) => _scriptApi.getById(id: sipId))
          .then((scriptDO) => Script.from(scriptDO: scriptDO));

  Future<double> executeScript({required final String script}) async {
    final result = _dslParserDefinition.start().parse(script);

    if (result.value != null) {
      final apiUrl = result.value[0];
      final params = result.value[1];
      final jsonPath = result.value[2];
      final operation = result.value[3];

      var response = await http.get(Uri.https(apiUrl, '', params));
      final data = json.decode(response.body);
      final extractedData = data[jsonPath];

      if (operation == 'add') {
        return extractedData.reduce((value, element) => value + element);
      } else if (operation == 'multiply') {
        return extractedData.reduce((value, element) => value * element);
      }
    }

    return 0.0;
  }
}
