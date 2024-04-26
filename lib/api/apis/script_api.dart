import 'package:drift/drift.dart';
import 'package:wealth_wave/api/db/app_database.dart';

class ScriptApi {
  final AppDatabase _db;

  ScriptApi({final AppDatabase? db}) : _db = db ?? AppDatabase.instance;

  Future<int> create(
      {required final int investmentId, required final String script}) async {
    return _db.into(_db.scriptTable).insert(ScriptTableCompanion.insert(
        investmentId: investmentId, script: script));
  }

  Future<List<ScriptDO>> getAll() async {
    return (_db.select(_db.scriptTable)).get();
  }

  Future<ScriptDO> getBy({final int? investmentId}) async {
    if (investmentId != null) {
      return (_db.select(_db.scriptTable)
            ..where((t) => t.investmentId.equals(investmentId)))
          .getSingle();
    }

    throw Exception("Investment Id is null");
  }

  Future<ScriptDO> getById({required final int id}) async {
    return (_db.select(_db.scriptTable)..where((t) => t.id.equals(id)))
        .getSingle();
  }

  Future<int> update(
      {required final int id,
      required final int investmentId,
      required final String script}) async {
    return (_db.update(_db.scriptTable)..where((t) => t.id.equals(id))).write(
        ScriptTableCompanion(
            investmentId: Value(investmentId), script: Value(script)));
  }

  Future<int> deleteBy({final int? id, final int? investmentId}) async {
    if (id != null) {
      return (_db.delete(_db.scriptTable)..where((t) => t.id.equals(id))).go();
    } else if (investmentId != null) {
      return (_db.delete(_db.scriptTable)
            ..where((t) => t.investmentId.equals(investmentId)))
          .go();
    }
    throw Exception('Invalid delete call');
  }
}
