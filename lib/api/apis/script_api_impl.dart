import 'package:drift/drift.dart';
import 'package:wealth_wave/api/apis/script_api.dart';
import 'package:wealth_wave/api/db/app_database.dart';

class ScriptApiImpl implements ScriptApi {
  final AppDatabase _db;

  ScriptApiImpl({final AppDatabase? db}) : _db = db ?? AppDatabase.instance;

  @override
  Future<int> create(
      {required final int investmentId, required final String script}) async {
    return _db.into(_db.scriptTable).insert(ScriptTableCompanion.insert(
        investmentId: investmentId, script: script));
  }

  @override
  Future<List<ScriptDO>> getAll() async {
    return (_db.select(_db.scriptTable)).get();
  }

  @override
  Future<ScriptDO?> getBy({final int? investmentId}) async {
    if (investmentId != null) {
      return (_db.select(_db.scriptTable)
            ..where((t) => t.investmentId.equals(investmentId)))
          .getSingleOrNull();
    }

    throw Exception("Investment Id is null");
  }

  @override
  Future<ScriptDO> getById({required final int id}) async {
    return (_db.select(_db.scriptTable)..where((t) => t.id.equals(id)))
        .getSingle();
  }

  @override
  Future<int> update(
      {required final int id,
      required final int investmentId,
      required final String script}) async {
    return (_db.update(_db.scriptTable)..where((t) => t.id.equals(id))).write(
        ScriptTableCompanion(
            investmentId: Value(investmentId), script: Value(script)));
  }

  @override
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
