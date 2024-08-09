import 'package:drift/drift.dart';
import 'package:wealth_wave/api/db/app_database.dart';

class AggregatedExpenseApi {
  final AppDatabase _db;

  AggregatedExpenseApi({final AppDatabase? db})
      : _db = db ?? AppDatabase.instance;

  Future<int> create(
      {required final double amount,
      required final DateTime month,
      required final String tags}) async {
    return _db.into(_db.aggregatedExpenseTable).insert(
        AggregatedExpenseTableCompanion.insert(
            amount: amount, tags: tags, month: month));
  }

  Future<List<AggregatedExpenseDO>> get() async {
    return (_db.select(_db.aggregatedExpenseTable)
          ..orderBy([(t) => OrderingTerm(expression: t.month)]))
        .get();
  }

  Future<AggregatedExpenseDO> getBy({required final int id}) async {
    return (_db.select(_db.aggregatedExpenseTable)
          ..where((t) => t.id.equals(id)))
        .getSingle();
  }

  Future<AggregatedExpenseDO?> getByMonthAndTag(
      {required final DateTime month, required final String tags}) async {
    return (_db.select(_db.aggregatedExpenseTable)
          ..where((t) => t.month.equals(month) & t.tags.equals(tags)))
        .getSingleOrNull();
  }

  Future<int> update(
      {required final int id,
      required final double amount,
      required final DateTime month,
      required final String tags}) async {
    return (_db.update(_db.aggregatedExpenseTable)
          ..where((t) => t.id.equals(id)))
        .write(AggregatedExpenseTableCompanion(
            amount: Value(amount), tags: Value(tags), month: Value(month)));
  }

  Future<int> deleteBy({required final int id}) async {
    return (_db.delete(_db.aggregatedExpenseTable)
          ..where((t) => t.id.equals(id)))
        .go();
  }

  Future<int> deleteByMonthDate({required final DateTime month}) async {
    return (_db.delete(_db.aggregatedExpenseTable)
          ..where((t) => t.month.equals(month)))
        .go();
  }
}
