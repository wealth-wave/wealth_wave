import 'package:drift/drift.dart';
import 'package:wealth_wave/api/db/app_database.dart';
import 'package:wealth_wave/contract/risk_level.dart';

class InvestmentApi {
  final AppDatabase _db;

  InvestmentApi({final AppDatabase? db}) : _db = db ?? AppDatabase.instance;

  Future<List<InvestmentDO>> getInvestments() async {
    return (_db.select(_db.investmentTable)
          ..orderBy([(t) => OrderingTerm.asc(t.name)]))
        .get();
  }

  Future<List<InvestmentEnrichedDO>> getEnrichedInvestments() async {
    return (_db.select(_db.investmentEnrichedView)
          ..orderBy([(t) => OrderingTerm.asc(t.name)]))
        .get();
  }

  Future<List<TransactionDO>> getTransactions({final int? investmentId}) async {
    if (investmentId == null) {
      return (_db.select(_db.transactionTable)
            ..orderBy([(t) => OrderingTerm.desc(t.amountInvestedOn)]))
          .get();
    } else {
      return (_db.select(_db.transactionTable)
            ..where((t) => t.investmentId.equals(investmentId))
            ..orderBy([(t) => OrderingTerm.desc(t.amountInvestedOn)]))
          .get();
    }
  }

  Future<int> createInvestment({
    required final String name,
    required final int? basketId,
    required final RiskLevel riskLevel,
    required final double value,
    required final DateTime valueUpdatedAt,
  }) async {
    return _db.into(_db.investmentTable).insert(InvestmentTableCompanion.insert(
        name: name,
        basketId: Value(basketId),
        value: value,
        riskLevel: riskLevel,
        valueUpdatedOn: valueUpdatedAt));
  }

  Future<int> createTransaction(
      {required final int investmentId,
      required final double amount,
      required final DateTime date}) async {
    return _db.into(_db.transactionTable).insert(
        TransactionTableCompanion.insert(
            investmentId: investmentId,
            amount: amount,
            amountInvestedOn: date));
  }

  Future<int> deleteTransaction({required final int id}) async {
    return (_db.delete(_db.transactionTable)..where((t) => t.id.equals(id)))
        .go();
  }

  Future<int> updateInvestment({
    required final int id,
    required final String name,
    required final int? basketId,
    required final RiskLevel riskLevel,
    required final double value,
    required final DateTime valueUpdatedAt,
  }) async {
    return (_db.update(_db.investmentTable)..where((t) => t.id.equals(id)))
        .write(InvestmentTableCompanion(
            name: Value(name),
            basketId: Value(basketId),
            riskLevel: Value(riskLevel),
            value: Value(value),
            valueUpdatedOn: Value(valueUpdatedAt)));
  }

  Future<int> updateTransaction(
      {required final int id,
      required final int investmentId,
      required final double amount,
      required final DateTime date}) async {
    return (_db.update(_db.transactionTable)..where((t) => t.id.equals(id)))
        .write(TransactionTableCompanion(
      investmentId: Value(investmentId),
      amount: Value(amount),
      amountInvestedOn: Value(date),
    ));
  }

  Future<int> deleteTransactions({required final int investmentId}) async {
    return (_db.delete(_db.transactionTable)
          ..where((t) => t.investmentId.equals(investmentId)))
        .go();
  }

  Future<int> deleteInvestment({required final int id}) async {
    return (_db.delete(_db.investmentTable)..where((t) => t.id.equals(id)))
        .go();
  }
}
