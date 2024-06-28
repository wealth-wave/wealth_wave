import 'package:wealth_wave/api/db/app_database.dart';

abstract class ScriptApi {
  Future<int> create(
      {required final int investmentId, required final String script});

  Future<List<ScriptDO>> getAll();

  Future<ScriptDO?> getBy({final int? investmentId});

  Future<ScriptDO> getById({required final int id});

  Future<int> update(
      {required final int id,
      required final int investmentId,
      required final String script});

  Future<int> deleteBy({final int? id, final int? investmentId});
}
