import 'package:drift/drift.dart';
import 'package:wealth_wave/api/db/app_database.dart';

class ExpenseApi {
  final AppDatabase _db;

  ExpenseApi({final AppDatabase? db}) : _db = db ?? AppDatabase.instance;

  Future<int> create(
      {required final double amount,
      required final String? description,
      required final DateTime createdOn,
      required final List<String> tags}) async {
    return _db.into(_db.expenseTable).insert(ExpenseTableCompanion.insert(
        amount: Value(amount),
        description: Value(description),
        tags: Value(tags.join(',')),
        createdOn: Value(createdOn)));
  }

  Future<List<ExpenseDO>> get() async {
    return (_db.select(_db.expenseTable)
          ..orderBy([(t) => OrderingTerm(expression: t.createdOn)]))
        .get();
  }

  Future<ExpenseDO> getBy({required final int id}) async {
    return (_db.select(_db.expenseTable)..where((t) => t.id.equals(id)))
        .getSingle();
  }

  Future<int> update(
      {required final int id,
      required final double amount,
      required final String? description,
      required final DateTime createdOn,
      required final List<String> tags}) async {
    return (_db.update(_db.expenseTable)..where((t) => t.id.equals(id))).write(
        ExpenseTableCompanion(
            amount: Value(amount),
            description: Value(description),
            tags: Value(tags.join(',')),
            createdOn: Value(createdOn)));
  }

  Future<int> deleteBy({required final int id}) async {
    return (_db.delete(_db.expenseTable)..where((t) => t.id.equals(id)))
        .go();
  }
}
