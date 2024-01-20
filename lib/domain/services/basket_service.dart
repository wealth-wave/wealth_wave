import 'package:wealth_wave/api/apis/basket_api.dart';
import 'package:wealth_wave/domain/models/basket.dart';

class BasketService {
  final BasketApi _basketApi;

  factory BasketService() {
    return _instance;
  }

  static final BasketService _instance = BasketService._();

  BasketService._({BasketApi? basketApi})
      : _basketApi = basketApi ?? BasketApi();

  Future<Basket> create(
      {required final String name, required final String description}) {
    return _basketApi
        .create(name: name, description: description)
        .then((basketId) => _basketApi.getBy(id: basketId))
        .then((basketDO) => Basket.from(basketDO: basketDO));
  }

  Future<List<Basket>> get() async {
    return _basketApi.get().then((baskets) =>
        baskets.map((basketDO) => Basket.from(basketDO: basketDO)).toList());
  }

  Future<Basket> getBy({required final int id}) async {
    return _basketApi.getBy(id: id).then((basketDO) {
      return Basket.from(basketDO: basketDO);
    });
  }

  Future<Basket> update(Basket basket) {
    return _basketApi
        .update(
            id: basket.id, name: basket.name, description: basket.description)
        .then((value) => _basketApi.getBy(id: basket.id))
        .then((basketDO) => Basket.from(basketDO: basketDO));
  }

  Future<void> deleteBy({required final int id}) {
    return _basketApi.deleteBy(id: id);
  }
}
