import 'package:drift/drift.dart';
import 'package:wealth_wave/api/db/app_database.dart';

class AggregatedExpenseApi {
  final AppDatabase _db;

  AggregatedExpenseApi({final AppDatabase? db})
      : _db = db ?? AppDatabase.instance;

  Future<int> create(
      {required final double amount,
      required final int year,
      required final int month,
      required final String tags}) async {
    return _db.into(_db.aggregatedExpenseTable).insert(
        AggregatedExpenseTableCompanion.insert(
            amount: amount, tags: tags, year: year, month: month));
  }

  Future<List<AggregatedExpenseDO>> get() async {
    return (_db.select(_db.aggregatedExpenseTable)
          ..orderBy([(t) => OrderingTerm(expression: t.year)]))
        .get();
  }

  Future<AggregatedExpenseDO> getBy({required final int id}) async {
    return (_db.select(_db.aggregatedExpenseTable)
          ..where((t) => t.id.equals(id)))
        .getSingle();
  }

  Future<AggregatedExpenseDO?> getByMonthAndTag(
      {required final int year, required final int month, required final String tags}) async {
    return (_db.select(_db.aggregatedExpenseTable)
          ..where((t) =>
              t.year.equals(year) & t.month.equals(month) & t.tags.equals(tags)))
        .getSingleOrNull();
  }

  Future<int> update(
      {required final int id,
      required final double amount,
      required final int year,
      required final int month,
      required final String tags}) async {
    return (_db.update(_db.aggregatedExpenseTable)
          ..where((t) => t.id.equals(id)))
        .write(AggregatedExpenseTableCompanion(
            amount: Value(amount),
            tags: Value(tags),
            year: Value(year),
            month: Value(month)));
  }

  Future<int> deleteBy({required final int id}) async {
    return (_db.delete(_db.aggregatedExpenseTable)
          ..where((t) => t.id.equals(id)))
        .go();
  }

  Future<int> deleteByMonthDate({required final int year, required final int month}) async {
    return (_db.delete(_db.aggregatedExpenseTable)
          ..where((t) => t.year.equals(year) & t.month.equals(month)))
        .go();
  }
}
