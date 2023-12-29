import 'package:drift/drift.dart';
import 'package:wealth_wave/api/db/app_database.dart';
import 'package:wealth_wave/contract/risk_level.dart';

class InvestmentApi {
  final AppDatabase _db;

  InvestmentApi({final AppDatabase? db}) : _db = db ?? AppDatabase.instance;

  Future<List<InvestmentEnriched>> getInvestments() {
    return _db.select(_db.investmentEnrichedView).get();
  }

  Future<List<InvestmentTransaction>> getTransactions({required final int investmentId}) {
    return (_db.select(_db.investmentTransactionTable)
          ..where((t) => t.investmentId.equals(investmentId)))
        .get();
  }

  Future<int> createInvestment({
    required final String name,
    required final int? basketId,
    required final RiskLevel riskLevel,
    required final double value,
    required final DateTime valueUpdatedAt,
  }) {
    return _db.into(_db.investmentTable).insert(InvestmentTableCompanion.insert(
        name: name,
        basketId: Value(basketId),
        value: 0,
        riskLevel: riskLevel,
        valueUpdatedOn: valueUpdatedAt));
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

  Future<void> updateInvestment({
    required final int id,
    required final String name,
    required final int? basketId,
    required final RiskLevel riskLevel,
    required final double value,
    required final DateTime valueUpdatedAt,
  }) {
    return (_db.update(_db.investmentTable)..where((t) => t.id.equals(id)))
        .write(InvestmentTableCompanion(
            name: Value(name),
            basketId: Value(basketId),
            riskLevel: Value(riskLevel),
            value: Value(value),
            valueUpdatedOn: Value(valueUpdatedAt)));
  }

  Future<void> updateTransaction(
      {required final int id,
      required final int investmentId,
      required final double amount,
      required final DateTime date}) {
    return (_db.update(_db.investmentTransactionTable)
          ..where((t) => t.id.equals(id)))
        .write(InvestmentTransactionTableCompanion(
      investmentId: Value(investmentId),
      amount: Value(amount),
      amountInvestedOn: Value(date),
    ));
  }

  Future<void> deleteInvestment({required final int id}) {
    return (_db.delete(_db.investmentTransactionTable)
          ..where((t) => t.investmentId.equals(id)))
        .go();
  }

  Future<void> deleteTransaction({required final int id}) {
    return (_db.delete(_db.investmentTable)..where((t) => t.id.equals(id)))
        .go();
  }
}
