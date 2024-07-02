import 'package:drift/drift.dart';
import 'package:wealth_wave/api/db/app_database.dart';

class ExpenseTagApi {
  final AppDatabase _db;

  ExpenseTagApi({final AppDatabase? db}) : _db = db ?? AppDatabase.instance;

  Future<int> create(
      {required final String name, required final String? description}) async {
    return _db.into(_db.expenseTagTable).insert(ExpenseTagTableCompanion.insert(
        name: name, description: Value(description)));
  }

  Future<List<ExpenseTagDO>> get() async {
    return (_db.select(_db.expenseTagTable)
          ..orderBy([(t) => OrderingTerm(expression: t.name)]))
        .get();
  }

  Future<ExpenseTagDO> getBy({required final int id}) async {
    return (_db.select(_db.expenseTagTable)..where((t) => t.id.equals(id)))
        .getSingle();
  }

  Future<int> update(
      {required final int id,
      required final String name,
      required final String? description}) async {
    return (_db.update(_db.expenseTagTable)..where((t) => t.id.equals(id)))
        .write(ExpenseTagTableCompanion(
      name: Value(name),
      description: Value(description),
    ));
  }

  Future<int> deleteBy({required final int id}) async {
    return (_db.delete(_db.expenseTagTable)..where((t) => t.id.equals(id))).go();
  }
}
