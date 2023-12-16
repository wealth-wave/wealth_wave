import 'package:wealth_wave/api/apis/basket_api.dart';
import 'package:wealth_wave/domain/models/basket.dart';

class GetBasketsUseCase {
  final BasketApi _basketApi;

  GetBasketsUseCase({final BasketApi? basketApi})
      : _basketApi = basketApi ?? BasketApi();

  Future<List<Basket>> getBaskets() {
    return _basketApi
        .getBaskets()
        .then((value) => value.map((e) => Basket.from(e)).toList());
  }
}
