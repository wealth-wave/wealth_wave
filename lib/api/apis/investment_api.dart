import 'package:drift/drift.dart';
import 'package:wealth_wave/api/db/app_database.dart';
import 'package:wealth_wave/contract/goal_importance.dart';
import 'package:wealth_wave/contract/risk_level.dart';

class InvestmentApi {
  final AppDatabase _db;

  InvestmentApi({final AppDatabase? db}) : _db = db ?? AppDatabase.instance;

  Stream<List<Investment>> getInvestments() {
    return _db.select(_db.investmentTable).watch();
  }

  Stream<List<InvestmentTransaction>> getTransactions() {
    return _db.select(_db.investmentTransactionTable).watch();
  }

  Future<int> createInvestment({
    required final String name,
    required final int basketId,
    required final RiskLevel riskLevel,
    required final DateTime date,
  }) {
    return _db.into(_db.investmentTable).insert(InvestmentTableCompanion.insert(
        name: name,
        basketId: basketId,
        value: 0,
        riskLevel: riskLevel,
        valueUpdatedOn: date));
  }

  Future<void> createTransaction(
      {required final int investmentId,
      required final double amount,
      required final DateTime date}) {
    return _db.into(_db.investmentTransactionTable).insert(
        InvestmentTransactionTableCompanion.insert(
            investmentId: investmentId,
            amount: amount,
            amountInvestedOn: date));
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

  Future<void> deleteInvestment({required final int id}) {
    return Future.wait([
      (_db.delete(_db.investmentTransactionTable)
            ..where((t) => t.investmentId.equals(id)))
          .go(),
      (_db.delete(_db.investmentTable)..where((t) => t.id.equals(id))).go()
    ]);
  }
}
