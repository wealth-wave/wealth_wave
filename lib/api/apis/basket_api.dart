import 'package:drift/drift.dart';
import 'package:wealth_wave/api/db/app_database.dart';

class BasketApi {
  final AppDatabase _db;

  BasketApi({final AppDatabase? db}) : _db = db ?? AppDatabase.instance;

  Future<int> create(
      {required final String name, required final String? description}) async {
    return _db.into(_db.basketTable).insert(BasketTableCompanion.insert(
        name: name, description: Value(description)));
  }

  Future<List<BasketDO>> get() async {
    return (_db.select(_db.basketTable)
          ..orderBy([(t) => OrderingTerm(expression: t.name)]))
        .get();
  }

  Future<int> update(
      {required final int id,
      required final String name,
      required final String? description}) async {
    return (_db.update(_db.basketTable)..where((t) => t.id.equals(id)))
        .write(BasketTableCompanion(
      name: Value(name),
      description: Value(description),
    ));
  }

  Future<int> deleteBy({required final int id}) async {
    return (_db.delete(_db.basketTable)..where((t) => t.id.equals(id))).go();
  }
}
