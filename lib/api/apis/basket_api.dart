import 'package:drift/drift.dart';
import 'package:wealth_wave/api/db/app_database.dart';

class BasketApi {
  final AppDatabase _db;

  BasketApi({final AppDatabase? db}) : _db = db ?? AppDatabase.instance;

  Future<List<BasketDTO>> getBaskets() {
    return _db.select(_db.basket).get();
  }

  Future<void> createBasket({required final String name}) {
    return _db.into(_db.basket).insert(BasketCompanion.insert(name: name));
  }

  Future<void> updateName({required final int id, required final String name}) {
    return (_db.update(_db.basket)..where((t) => t.id.equals(id)))
        .write(BasketCompanion(
      name: Value(name),
    ));
  }

  Future<void> deleteBasket({required final int id}) {
    return (_db.delete(_db.basket)..where((t) => t.id.equals(id))).go();
  }
}
