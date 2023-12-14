import 'package:wealth_wave/api/apis/basket_api.dart';

class DeleteBasketUseCase {
  final BasketApi _basketApi;

  DeleteBasketUseCase({BasketApi? basketApi})
      : _basketApi = basketApi ?? BasketApi();

  Future<void> deleteBasket(int id) {
    return _basketApi.deleteBasket(id);
  }
}
