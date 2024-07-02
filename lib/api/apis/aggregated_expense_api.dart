import 'package:drift/drift.dart';
import 'package:wealth_wave/api/db/app_database.dart';

class AggregatedExpenseApi {
  final AppDatabase _db;

  AggregatedExpenseApi({final AppDatabase? db})
      : _db = db ?? AppDatabase.instance;

  Future<int> create(
      {required final double amount,
      required final DateTime monthDate,
      required final List<String> tags}) async {
    return _db.into(_db.aggregatedExpenseTable).insert(
        AggregatedExpenseTableCompanion.insert(
            amount: Value(amount),
            tags: Value(tags.join(',')),
            createdMonthDate: Value(monthDate)));
  }

  Future<List<AggregatedExpenseDO>> get() async {
    return (_db.select(_db.aggregatedExpenseTable)
          ..orderBy([(t) => OrderingTerm(expression: t.createdMonthDate)]))
        .get();
  }

  Future<AggregatedExpenseDO> getBy({required final int id}) async {
    return (_db.select(_db.aggregatedExpenseTable)
          ..where((t) => t.id.equals(id)))
        .getSingle();
  }

  Future<int> update(
      {required final int id,
      required final double amount,
      required final DateTime createdOn,
      required final List<String> tags}) async {
    return (_db.update(_db.aggregatedExpenseTable)
          ..where((t) => t.id.equals(id)))
        .write(AggregatedExpenseTableCompanion(
            amount: Value(amount),
            tags: Value(tags.join(',')),
            createdMonthDate: Value(createdOn)));
  }

  Future<int> deleteBy({required final int id}) async {
    return (_db.delete(_db.aggregatedExpenseTable)
          ..where((t) => t.id.equals(id)))
        .go();
  }
}
