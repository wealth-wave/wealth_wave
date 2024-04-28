import 'package:drift/drift.dart';
import 'package:wealth_wave/api/db/app_database.dart';
import 'package:wealth_wave/contract/risk_level.dart';

class InvestmentApi {
  final AppDatabase _db;

  InvestmentApi({final AppDatabase? db}) : _db = db ?? AppDatabase.instance;

  Future<int> create({
    required final String name,
    required final String? description,
    required final int? basketId,
    required final RiskLevel riskLevel,
    required final double? value,
    required final double? qty,
    required final DateTime? valueUpdatedOn,
    required final double? irr,
    required final DateTime? maturityDate,
  }) async {
    return _db.into(_db.investmentTable).insert(InvestmentTableCompanion.insert(
        name: name,
        description: Value(description),
        basketId: Value(basketId),
        value: Value(value),
        qty: Value(qty),
        irr: Value(irr),
        maturityDate: Value(maturityDate),
        valueUpdatedOn: Value(valueUpdatedOn),
        riskLevel: riskLevel));
  }

  Future<List<InvestmentDO>> getAll() async {
    return (_db.select(_db.investmentEnrichedView)
          ..orderBy([(t) => OrderingTerm.asc(t.name)]))
        .get();
  }

  Future<List<InvestmentDO>> getEnriched() async {
    return (_db.select(_db.investmentEnrichedView)
          ..orderBy([(t) => OrderingTerm.asc(t.name)]))
        .get();
  }

  Future<InvestmentDO> getById({required final int id}) async {
    return (_db.select(_db.investmentEnrichedView)
          ..where((t) => t.id.equals(id)))
        .getSingle();
  }

  Future<List<InvestmentDO>> getBy({final int? basketId}) async {
    if (basketId != null) {
      return (_db.select(_db.investmentEnrichedView)
            ..where((t) => t.basketId.equals(basketId)))
          .get();
    }

    throw Exception('basketId is null');
  }

  Future<int> update({
    required final int id,
    required final String name,
    required final String? description,
    required final double? value,
    required final double? qty,
    required final DateTime? valueUpdatedOn,
    required final double? irr,
    required final DateTime? maturityDate,
    required final RiskLevel riskLevel,
    required final int? basketId,
  }) async {
    return (_db.update(_db.investmentTable)..where((t) => t.id.equals(id)))
        .write(InvestmentTableCompanion(
            name: Value(name),
            description: Value(description),
            basketId: Value(basketId),
            riskLevel: Value(riskLevel),
            value: Value(value),
            qty: Value(qty),
            valueUpdatedOn: Value(valueUpdatedOn),
            irr: Value(irr),
            maturityDate: Value(maturityDate)));
  }

  Future<int> updateValue({
    required final int id,
    required final double value,
    required final DateTime valueUpdatedOn,
  }) async {
    return (_db.update(_db.investmentTable)..where((t) => t.id.equals(id)))
        .write(InvestmentTableCompanion(
            value: Value(value), valueUpdatedOn: Value(valueUpdatedOn)));
  }

  Future<int> deleteBy({required final int id}) async {
    return (_db.delete(_db.investmentTable)..where((t) => t.id.equals(id)))
        .go();
  }
}
