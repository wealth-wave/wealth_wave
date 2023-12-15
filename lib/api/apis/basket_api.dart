import 'package:drift/drift.dart';
import 'package:wealth_wave/api/db/app_database.dart';
import 'package:wealth_wave/domain/models/basket.dart';

class BasketApi {
  final AppDatabase _db;

  BasketApi({AppDatabase? db}) : _db = db ?? AppDatabase.instance;

  Future<List<Basket>> getBaskets() {
    return _db
        .select(_db.basketTable)
        .get()
        .then((value) => value.map((e) => Basket(e.id, e.name)).toList());
  }

  Future<void> addBasket(String name) {
    return _db
        .into(_db.basketTable)
        .insert(BasketTableCompanion.insert(name: name));
  }

  Future<void> updateName(int id, String name) {
    return (_db.update(_db.basketTable)..where((t) => t.id.equals(id)))
        .write(BasketTableCompanion(
      name: Value(name),
    ));
  }

  Future<void> deleteBasket(int id) {
    return (_db.delete(_db.basketTable)..where((t) => t.id.equals(id))).go();
  }
}
