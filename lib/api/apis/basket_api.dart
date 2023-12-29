import 'package:drift/drift.dart';
import 'package:wealth_wave/api/db/app_database.dart';

class BasketApi {
  final AppDatabase _db;

  BasketApi({final AppDatabase? db}) : _db = db ?? AppDatabase.instance;

  Future<List<Basket>> getBaskets() {
    return _db.select(_db.basketTable).get();
  }

  Future<void> createBasket({required final String name}) {
    return _db
        .into(_db.basketTable)
        .insert(BasketTableCompanion.insert(name: name));
  }

  Future<void> updateName({required final int id, required final String name}) {
    return (_db.update(_db.basketTable)..where((t) => t.id.equals(id)))
        .write(BasketTableCompanion(
      name: Value(name),
    ));
  }

  Future<void> deleteBasket({required final int id}) {
    return (_db.delete(_db.basketTable)..where((t) => t.id.equals(id))).go();
  }
}
