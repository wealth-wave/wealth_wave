import 'package:wealth_wave/api/apis/basket_api.dart';

class AddBasketUseCase {
  final BasketApi _basketApi;

  AddBasketUseCase({BasketApi? basketApi})
      : _basketApi = basketApi ?? BasketApi();

  Future<void> addBasket(String name) {
    return _basketApi.addBasket(name);
  }
}
