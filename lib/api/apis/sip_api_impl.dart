import 'package:drift/drift.dart';
import 'package:wealth_wave/api/apis/sip_api.dart';
import 'package:wealth_wave/api/db/app_database.dart';
import 'package:wealth_wave/contract/frequency.dart';

class SipApiImpl implements SipApi {
  final AppDatabase _db;

  SipApiImpl({final AppDatabase? db}) : _db = db ?? AppDatabase.instance;

  @override
  Future<int> create(
      {required final int investmentId,
      required final String? description,
      required final double amount,
      required final DateTime startDate,
      required final DateTime? endDate,
      required final Frequency frequency}) async {
    return _db.into(_db.sipTable).insert(SipTableCompanion.insert(
        investmentId: investmentId,
        description: Value(description),
        amount: amount,
        startDate: startDate,
        endDate: Value(endDate),
        frequency: frequency,
        executedTill: const Value(null)));
  }

  @override
  Future<List<SipDO>> getAll() async {
    return (_db.select(_db.sipEnrichedView)
          ..orderBy([(t) => OrderingTerm.desc(t.startDate)]))
        .get();
  }

  @override
  Future<List<SipDO>> getBy({final int? investmentId}) async {
    if (investmentId != null) {
      return (_db.select(_db.sipEnrichedView)
            ..where((t) => t.investmentId.equals(investmentId))
            ..orderBy([(t) => OrderingTerm.desc(t.startDate)]))
          .get();
    }

    throw Exception("Investment Id is null");
  }

  @override
  Future<SipDO> getById({required final int id}) async {
    return (_db.select(_db.sipEnrichedView)..where((t) => t.id.equals(id)))
        .getSingle();
  }

  @override
  Future<int> update(
      {required final int id,
      required final int investmentId,
      required final String? description,
      required final double amount,
      required final DateTime startDate,
      required final DateTime? endDate,
      required final Frequency frequency}) async {
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

  @override
  Future<int> deleteBy({final int? id, final int? investmentId}) async {
    if (id != null) {
      return (_db.delete(_db.sipTable)..where((t) => t.id.equals(id))).go();
    } else if (investmentId != null) {
      return (_db.delete(_db.sipTable)
            ..where((t) => t.investmentId.equals(investmentId)))
          .go();
    }
    throw Exception('Invalid delete call');
  }
}
