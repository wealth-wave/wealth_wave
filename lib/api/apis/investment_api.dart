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

  Future<List<SipDO>> getSips({final int? investmentId}) async {
    if (investmentId == null) {
      return (_db.select(_db.sipTable)
            ..orderBy([(t) => OrderingTerm.desc(t.startDate)]))
          .get();
    } else {
      return (_db.select(_db.sipTable)
            ..where((t) => t.investmentId.equals(investmentId))
            ..orderBy([(t) => OrderingTerm.desc(t.startDate)]))
          .get();
    }
  }

  Future<int> createInvestment({
    required final String name,
    required final String? description,
    required final int? basketId,
    required final RiskLevel riskLevel,
    required final double? currentValue,
    required final DateTime? currentValueUpdatedAt,
    required final double? irr,
    required final DateTime? maturityDate,
  }) async {
    return _db.into(_db.investmentTable).insert(InvestmentTableCompanion.insert(
        name: name,
        basketId: Value(basketId),
        description: Value(description),
        currentValue: Value(currentValue),
        irr: Value(irr),
        maturityDate: Value(maturityDate),
        currentValueUpdatedOn: Value(currentValueUpdatedAt),
        riskLevel: riskLevel));
  }

  Future<int> createTransaction(
      {required final int investmentId,
      required final String? description,
      required final double amount,
      required final DateTime date,
      final int? sipId}) async {
    return _db.into(_db.transactionTable).insert(
        TransactionTableCompanion.insert(
            investmentId: investmentId,
            description: Value(description),
            amount: amount,
            sipId: Value(sipId),
            amountInvestedOn: date));
  }

  Future<int> createSip(
      {required final int investmentId,
      required final String? description,
      required final double amount,
      required final DateTime startDate,
      required final DateTime endDate,
      required final double frequency}) async {
    return _db.into(_db.sipTable).insert(SipTableCompanion.insert(
        investmentId: investmentId,
        description: Value(description),
        amount: amount,
        startDate: startDate,
        endDate: endDate,
        frequency: frequency,
        executedTill: const Value(null)));
  }

  Future<int> deleteTransaction({required final int id}) async {
    return (_db.delete(_db.transactionTable)..where((t) => t.id.equals(id)))
        .go();
  }

  Future<int> deleteSip({required final int id}) async {
    return (_db.delete(_db.sipTable)..where((t) => t.id.equals(id))).go();
  }

  Future<int> deleteSips({required final int investmentId}) async {
    return (_db.delete(_db.sipTable)
          ..where((t) => t.investmentId.equals(investmentId)))
        .go();
  }

  Future<int> updateInvestment({
    required final int id,
    required final String name,
    required final String? description,
    required final int? basketId,
    required final RiskLevel riskLevel,
    required final double? currentValue,
    required final double? irr,
    required final DateTime? maturityDate,
    required final DateTime currentValueUpdatedOn,
  }) async {
    return (_db.update(_db.investmentTable)..where((t) => t.id.equals(id)))
        .write(InvestmentTableCompanion(
            name: Value(name),
            description: Value(description),
            basketId: Value(basketId),
            riskLevel: Value(riskLevel),
            currentValue: Value(currentValue),
            irr: Value(irr),
            maturityDate: Value(maturityDate),
            currentValueUpdatedOn: Value(currentValueUpdatedOn)));
  }

  Future<int> updateTransaction(
      {required final int id,
      required final int investmentId,
      required final String? description,
      required final double amount,
      required final DateTime date}) async {
    return (_db.update(_db.transactionTable)..where((t) => t.id.equals(id)))
        .write(TransactionTableCompanion(
      investmentId: Value(investmentId),
      description: Value(description),
      amount: Value(amount),
      amountInvestedOn: Value(date),
    ));
  }

  Future<int> updateSip(
      {required final int id,
      required final int investmentId,
      required final String? description,
      required final double amount,
      required final DateTime startDate,
      required final DateTime endDate,
      required final double frequency}) async {
    return (_db.update(_db.sipTable)..where((t) => t.id.equals(id))).write(
        SipTableCompanion(
            investmentId: Value(investmentId),
            description: Value(description),
            amount: Value(amount),
            startDate: Value(startDate),
            endDate: Value(endDate),
            frequency: Value(frequency),
            executedTill: const Value.absent()));
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

  Future<List<GoalInvestmentEnrichedMappingDO>> getGoalInvestmentMappings(
      {final int? investmentId}) async {
    if (investmentId != null) {
      return (_db.select(_db.goalInvestmentEnrichedMappingView)
            ..where((t) => t.investmentId.equals(investmentId)))
          .get();
    }
    return _db.select(_db.goalInvestmentEnrichedMappingView).get();
  }

  Future<int> createGoalInvestmentMap(
      {required final int goalId,
      required final int investmentId,
      required final double percentage}) async {
    return _db.into(_db.goalInvestmentTable).insert(
        GoalInvestmentTableCompanion.insert(
            goalId: goalId,
            investmentId: investmentId,
            sharePercentage: percentage));
  }

  Future<int> updateGoalInvestmentMap(
      {required final int id,
      required final int goalId,
      required final double percentage}) async {
    return (_db.update(_db.goalInvestmentTable)..where((t) => t.id.equals(id)))
        .write(GoalInvestmentTableCompanion(
            goalId: Value(goalId), sharePercentage: Value(percentage)));
  }

  Future<int> deleteGoalInvestmentMap({required final int id}) async {
    return (_db.delete(_db.goalInvestmentTable)..where((t) => t.id.equals(id)))
        .go();
  }
}
