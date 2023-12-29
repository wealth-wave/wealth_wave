import 'package:drift/drift.dart';
import 'package:wealth_wave/api/db/app_database.dart';
import 'package:wealth_wave/contract/goal_importance.dart';

class GoalApi {
  final AppDatabase _db;

  GoalApi({final AppDatabase? db}) : _db = db ?? AppDatabase.instance;

  Future<List<Goal>> getGoals() {
    return _db.select(_db.goalTable).get();
  }

  Future<Goal> getGoal({required final int id}) {
    return _db.select(_db.goalTable).getSingle();
  }

  Future<void> createGoal(
      {required final String name,
      required final double amount,
      required final DateTime date,
      required final double targetAmount,
      required final DateTime targetDate,
      required final double inflation,
      required final GoalImportance importance}) {
    return _db.into(_db.goalTable).insert(GoalTableCompanion.insert(
        name: name,
        amount: amount,
        date: date,
        targetAmount: targetAmount,
        targetDate: targetDate,
        inflation: inflation,
        importance: importance));
  }

  Future<void> update(
      {required final int id,
      required final String name,
      required final double amount,
      required final DateTime date,
      required final double targetAmount,
      required final DateTime targetDate,
      required final double inflation,
      required final GoalImportance importance}) {
    return (_db.update(_db.goalTable)..where((t) => t.id.equals(id))).write(
        GoalTableCompanion(
            name: Value(name),
            amount: Value(amount),
            date: Value(date),
            targetAmount: Value(targetAmount),
            targetDate: Value(targetDate),
            inflation: Value(inflation),
            importance: Value(importance)));
  }

  Future<void> deleteGoal({required final int id}) {
    return (_db.delete(_db.goalTable)..where((t) => t.id.equals(id))).go();
  }
}
