import 'package:drift/drift.dart';
import 'package:wealth_wave/api/db/app_database.dart';
import 'package:wealth_wave/contract/goal_importance.dart';

class GoalApi {
  final AppDatabase _db;

  GoalApi({final AppDatabase? db}) : _db = db ?? AppDatabase.instance;

  Future<int> create(
      {required final String name,
      required final String? description,
      required final double amount,
      required final DateTime amountUpdatedOn,
      required final DateTime maturityDate,
      required final double inflation,
      required final GoalImportance importance}) async {
    return _db.into(_db.goalTable).insert(GoalTableCompanion.insert(
        name: name,
        description: Value(description),
        amount: amount,
        amountUpdatedOn: amountUpdatedOn,
        maturityDate: maturityDate,
        inflation: inflation,
        importance: importance));
  }

  Future<List<GoalDO>> get() async {
    return (_db.select(_db.goalEnrichedView)
          ..orderBy([(t) => OrderingTerm.asc(t.maturityDate)]))
        .get();
  }

  Future<GoalDO> getBy({required final int id}) async {
    return (_db.select(_db.goalEnrichedView)..where((t) => t.id.equals(id)))
        .getSingle();
  }

  Future<int> update(
      {required final int id,
      required final String name,
      required final String? description,
      required final double amount,
      required final DateTime amountUpdatedOn,
      required final DateTime maturityDate,
      required final double inflation,
      required final GoalImportance importance}) async {
    return (_db.update(_db.goalTable)..where((t) => t.id.equals(id))).write(
        GoalTableCompanion(
            name: Value(name),
            description: Value(description),
            amount: Value(amount),
            amountUpdatedOn: Value(amountUpdatedOn),
            maturityDate: Value(maturityDate),
            inflation: Value(inflation),
            importance: Value(importance)));
  }

  Future<int> deleteBy({required final int id}) async {
    return (_db.delete(_db.goalTable)..where((t) => t.id.equals(id))).go();
  }
}
