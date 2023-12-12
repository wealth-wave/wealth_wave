import 'package:wealth_wave/api/db/app_database.dart';
import 'package:wealth_wave/domain/models/basket.dart';

class BasketApi {
  final AppDatabase _db;

  BasketApi({AppDatabase? db}) : _db = db ?? AppDatabase.instance;

  Future<List<Basket>> getBaskets() {
    return _db.select(_db.basketTable).get().then(
        (value) => value.map((e) => Basket(e.name, e.expectedSplit)).toList());
  }

  Future<void> saveBaskets(List<Basket> baskets) async {
    throw UnimplementedError();
  }
}
