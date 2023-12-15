import 'package:wealth_wave/api/apis/basket_api.dart';

class CreateBasketUseCase {
  final BasketApi _basketApi;

  CreateBasketUseCase({final BasketApi? basketApi})
      : _basketApi = basketApi ?? BasketApi();

  Future<void> createBasket({required String name}) {
    return _basketApi.createBasket(name: name);
  }
}
