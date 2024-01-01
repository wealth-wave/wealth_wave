import 'package:drift/drift.dart';
import 'package:wealth_wave/api/db/app_database.dart';

class BasketApi {
  final AppDatabase _db;

  BasketApi({final AppDatabase? db}) : _db = db ?? AppDatabase.instance;

  Future<List<BasketDO>> getBaskets() async {
    return (_db.select(_db.basketTable)
          ..orderBy([(t) => OrderingTerm(expression: t.name)]))
        .get();
  }

  Future<int> createBasket({required final String name}) async {
    return _db
        .into(_db.basketTable)
        .insert(BasketTableCompanion.insert(name: name));
  }

  Future<int> updateName(
      {required final int id, required final String name}) async {
    return (_db.update(_db.basketTable)..where((t) => t.id.equals(id)))
        .write(BasketTableCompanion(
      name: Value(name),
    ));
  }

  Future<int> deleteBasket({required final int id}) async {
    return (_db.delete(_db.basketTable)..where((t) => t.id.equals(id))).go();
  }
}
