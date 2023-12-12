import 'package:wealth_wave/api/apis/basket_api.dart';
import 'package:wealth_wave/domain/models/basket.dart';

class GetBasketsUseCase {
  final BasketApi _basketApi;

  GetBasketsUseCase({BasketApi? basketApi})
      : _basketApi = basketApi ?? BasketApi();

  Future<List<Basket>> getBaskets() async {
    return _basketApi.getBaskets();
  }
}
