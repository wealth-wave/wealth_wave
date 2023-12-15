import 'package:wealth_wave/api/apis/basket_api.dart';

class UpdateBasketUseCase {
  final BasketApi _basketApi;

  UpdateBasketUseCase({final BasketApi? basketApi})
      : _basketApi = basketApi ?? BasketApi();

  Future<void> update({required final int id, required final String name}) {
    return _basketApi.updateName(id: id, name: name);
  }
}
