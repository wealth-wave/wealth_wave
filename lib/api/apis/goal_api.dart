import 'package:drift/drift.dart';
import 'package:wealth_wave/api/db/app_database.dart';
import 'package:wealth_wave/contract/goal_importance.dart';
import 'package:wealth_wave/domain/models/goal.dart';

class GoalApi {
  final AppDatabase _db;

  GoalApi({final AppDatabase? db}) : _db = db ?? AppDatabase.instance;

  Future<List<Goal>> getGoals() {
    return _db.select(_db.goalTable).get().then((value) => value
        .map((e) => Goal(
            id: e.id,
            name: e.name,
            targetAmount: e.targetAmount,
            importance: e.importance,
            inflation: e.inflation,
            targetDate: e.targetDate))
        .toList());
  }

  Future<void> createGoal(
      {required final String name,
      required final double targetAmount,
      required final DateTime targetDate,
      required final double inflation,
      required final GoalImportance importance}) {
    return _db.into(_db.goalTable).insert(GoalTableCompanion.insert(
        name: name,
        targetAmount: targetAmount,
        targetDate: targetDate,
        inflation: inflation,
        importance: importance));
  }

  Future<void> update(
      {required final int id,
      required final String name,
      required final double targetAmount,
      required final DateTime targetDate,
      required final double inflation,
      required final GoalImportance importance}) {
    return (_db.update(_db.goalTable)..where((t) => t.id.equals(id))).write(
        GoalTableCompanion(
            name: Value(name),
            targetAmount: Value(targetAmount),
            targetDate: Value(targetDate),
            inflation: Value(inflation),
            importance: Value(importance)));
  }

  Future<void> deleteGoal({required final int id}) {
    return Future.wait([
      (_db.delete(_db.goalInvestmentMapTable)
            ..where((t) => t.goalId.equals(id)))
          .go(),
      (_db.delete(_db.goalTable)..where((t) => t.id.equals(id))).go()
    ]);
  }
}
