import 'package:drift/drift.dart';
import 'package:wealth_wave/api/apis/transaction_api.dart';
import 'package:wealth_wave/api/db/app_database.dart';

class TransactionApiImpl implements TransactionApi {
  final AppDatabase _db;

  TransactionApiImpl({final AppDatabase? db}) : _db = db ?? AppDatabase.instance;

  @override
  Future<int> create(
      {required final int investmentId,
      required final String? description,
      required final double amount,
      required final double qty,
      required final DateTime createdOn,
      final int? sipId}) async {
    return _db.into(_db.transactionTable).insert(
        TransactionTableCompanion.insert(
            investmentId: investmentId,
            description: Value(description),
            amount: amount,
            qty: Value(qty),
            sipId: Value(sipId),
            createdOn: createdOn));
  }

  @override
  Future<List<TransactionDO>> getAll() {
    return (_db.select(_db.transactionTable)
          ..orderBy([(t) => OrderingTerm.desc(t.createdOn)]))
        .get();
  }

  @override
  Future<List<TransactionDO>> getBy(
      {final int? investmentId, final int? sipId}) async {
    if (investmentId != null) {
      return (_db.select(_db.transactionTable)
            ..where((t) => t.investmentId.equals(investmentId))
            ..orderBy([(t) => OrderingTerm.desc(t.createdOn)]))
          .get();
    } else if (sipId != null) {
      return (_db.select(_db.transactionTable)
            ..where((t) => t.sipId.equals(sipId))
            ..orderBy([(t) => OrderingTerm.desc(t.createdOn)]))
          .get();
    }

    throw Exception('Invalid getBy call');
  }

  @override
  Future<TransactionDO> getById({required final int id}) async {
    return (_db.select(_db.transactionTable)
          ..where((t) => t.id.equals(id)))
        .getSingle();
  }

  @override
  Future<int> update(
      {required final int id,
      required final int investmentId,
      required final String? description,
      required final double amount,
      required final double qty,
      required final DateTime createdOn,
      final int? sipId}) async {
    return (_db.update(_db.transactionTable)..where((t) => t.id.equals(id)))
        .write(TransactionTableCompanion(
      investmentId: Value(investmentId),
      description: Value(description),
      amount: Value(amount),
      qty: Value(qty),
      createdOn: Value(createdOn),
      sipId: Value(sipId),
    ));
  }

  @override
  Future<int> deleteBy(
      {final int? investmentId, final int? sipId, final int? id}) async {
    if (id != null) {
      return (_db.delete(_db.transactionTable)..where((t) => t.id.equals(id)))
          .go();
    } else if (sipId != null) {
      return (_db.delete(_db.transactionTable)
            ..where((t) => t.sipId.equals(sipId)))
          .go();
    } else if (investmentId != null) {
      return (_db.delete(_db.transactionTable)
            ..where((t) => t.investmentId.equals(investmentId)))
          .go();
    }
    throw Exception('Invalid deleteTransactionsBy call');
  }
}
