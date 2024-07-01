import 'package:wealth_wave/api/db/app_database.dart';

class Basket {
  final int id;
  final String name;
  final String? description;

  Basket._(
      {required this.id,
      required this.name,
      required this.description});

  factory Basket.from({required final BasketDO basketDO}) =>
      Basket._(
          id: basketDO.id,
          name: basketDO.name,
          description: basketDO.description);
}
