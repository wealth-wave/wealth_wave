import 'package:wealth_wave/api/apis/basket_api.dart';

class UpdateBasketUseCase {
  final BasketApi _basketApi;

  UpdateBasketUseCase({BasketApi? basketApi})
      : _basketApi = basketApi ?? BasketApi();

  Future<void> update(int id, String name) {
    return _basketApi.updateName(id, name);
  }
}
