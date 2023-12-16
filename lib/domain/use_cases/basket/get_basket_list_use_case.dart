import 'package:wealth_wave/api/apis/basket_api.dart';
import 'package:wealth_wave/domain/models/basket.dart';

class GetBasketListUseCase {
  final BasketApi _basketApi;

  GetBasketListUseCase({final BasketApi? basketApi})
      : _basketApi = basketApi ?? BasketApi();

  Stream<List<Basket>> getBaskets() {
    return _basketApi
        .getBaskets()
        .map((value) => value.map((e) => Basket.from(e)).toList());
  }
}
