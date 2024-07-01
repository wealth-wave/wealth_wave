import 'package:wealth_wave/api/apis/basket_api.dart';
import 'package:wealth_wave/api/db/app_database.dart';
import 'package:wealth_wave/domain/models/basket.dart';

class BasketService {
  final BasketApi _basketApi;

  factory BasketService() {
    return _instance;
  }

  static final BasketService _instance = BasketService._();

  BasketService._({BasketApi? basketApi})
      : _basketApi = basketApi ?? BasketApi();

  Future<void> create(
          {required final String name, required final String description}) =>
      _basketApi.create(name: name, description: description).then((_) => {});

  Future<List<Basket>> get() async {
    List<BasketDO> basketDOs = await _basketApi.get();
    return basketDOs
        .map((basketDO) => Basket.from(basketDO: basketDO))
        .toList();
  }

  Future<Basket> getById({required final int id}) async {
    BasketDO basketDO = await _basketApi.getBy(id: id);
    return Basket.from(basketDO: basketDO);
  }

  Future<void> update(
          {required final int id,
          required final String name,
          required final String? description}) =>
      _basketApi
          .update(id: id, name: name, description: description)
          .then((_) => {});

  Future<void> deleteBy({required final int id}) => _basketApi.deleteBy(id: id);
}
