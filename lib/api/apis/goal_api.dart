import 'package:drift/drift.dart';
import 'package:wealth_wave/api/db/app_database.dart';
import 'package:wealth_wave/contract/goal_importance.dart';

class GoalApi {
  final AppDatabase _db;

  GoalApi({final AppDatabase? db}) : _db = db ?? AppDatabase.instance;

  Future<List<GoalDTO>> getGoals() {
    return _db.select(_db.goal).get();
  }

  Future<GoalDTO> getGoal({required final int id}) {
    return _db.select(_db.goal).getSingle();
  }

  Future<void> createGoal(
      {required final String name,
      required final double targetAmount,
      required final DateTime targetDate,
      required final double inflation,
      required final GoalImportance importance}) {
    return _db.into(_db.goal).insert(GoalCompanion.insert(
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
    return (_db.update(_db.goal)..where((t) => t.id.equals(id))).write(
        GoalCompanion(
            name: Value(name),
            targetAmount: Value(targetAmount),
            targetDate: Value(targetDate),
            inflation: Value(inflation),
            importance: Value(importance)));
  }

  Future<void> deleteGoal({required final int id}) {
    return Future.wait([
      (_db.delete(_db.goalInvestment)..where((t) => t.goalId.equals(id))).go(),
      (_db.delete(_db.goal)..where((t) => t.id.equals(id))).go()
    ]);
  }
}
