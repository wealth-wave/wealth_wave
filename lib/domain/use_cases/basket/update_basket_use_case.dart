import 'package:wealth_wave/api/apis/basket_api.dart';

class UpdateBasketUseCase {
  final BasketApi _basketApi;

  UpdateBasketUseCase({BasketApi? basketApi})
      : _basketApi = basketApi ?? BasketApi();

  Future<void> updateBasket(int id, String name) {
    return _basketApi.updateBasket(id, name);
  }
}
