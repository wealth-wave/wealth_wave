import 'package:drift/drift.dart';
import 'package:wealth_wave/api/db/app_database.dart';

class GoalInvestmentApi {
  final AppDatabase _db;

  GoalInvestmentApi({final AppDatabase? db}) : _db = db ?? AppDatabase.instance;

  Future<int> create(
      {required final int goalId,
      required final int investmentId,
      required final double split}) async {
    return _db.into(_db.goalInvestmentTable).insert(
        GoalInvestmentTableCompanion.insert(
            goalId: goalId, investmentId: investmentId, split: split));
  }

  Future<List<GoalInvestmentDO>> getBy(
      {final int? goalId, final int? investmentId}) async {
    if (goalId != null) {
      return (_db.select(_db.goalInvestmentTable)
            ..where((t) => t.goalId.equals(goalId)))
          .get();
    } else if (investmentId != null) {
      return (_db.select(_db.goalInvestmentTable)
            ..where((t) => t.investmentId.equals(investmentId)))
          .get();
    }
    throw Exception('Invalid getBy call');
  }

  Future<int> update(
      {required final int id,
      required final int goalId,
      required final int investmentId,
      required final double split}) async {
    return (_db.update(_db.goalInvestmentTable)..where((t) => t.id.equals(id)))
        .write(GoalInvestmentTableCompanion(
            investmentId: Value(investmentId),
            goalId: Value(goalId),
            split: Value(split)));
  }

  Future<int> deleteBy(
      {final int? id, final int? goalId, final int? investmentId}) async {
    if (id != null) {
      return (_db.delete(_db.goalInvestmentTable)
            ..where((t) => t.id.equals(id)))
          .go();
    } else if (goalId != null) {
      return (_db.delete(_db.goalInvestmentTable)
            ..where((t) => t.goalId.equals(goalId)))
          .go();
    } else if (investmentId != null) {
      return (_db.delete(_db.goalInvestmentTable)
            ..where((t) => t.investmentId.equals(investmentId)))
          .go();
    }
    throw Exception('Invalid deleteBy call');
  }
}
