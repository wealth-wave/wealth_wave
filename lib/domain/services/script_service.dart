import 'package:wealth_wave/api/apis/script_api.dart';
import 'package:wealth_wave/api/apis/script_api_impl.dart';
import 'package:wealth_wave/domain/models/script.dart';

class ScriptService {
  final ScriptApi _scriptApi;

  factory ScriptService() {
    return _instance;
  }

  static final ScriptService _instance = ScriptService._();

  ScriptService._({final ScriptApi? scriptApi})
      : _scriptApi = scriptApi ?? ScriptApiImpl();

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

  Future<Script?> getBy({required final int investmentId}) =>
      _scriptApi.getBy(investmentId: investmentId).then((scriptDO) {
        return scriptDO != null ? Script.from(scriptDO: scriptDO) : null;
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

  Future<void> deleteBy({required final int investmentId}) =>
      _scriptApi.deleteBy(investmentId: investmentId);
}
