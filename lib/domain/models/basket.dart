import 'package:wealth_wave/api/db/app_database.dart';

class Basket {
  final int id;
  final String name;

  Basket({required this.id, required this.name});

  static Basket from(BasketDTO basket) {
    return Basket(id: basket.id, name: basket.name);
  }
}
