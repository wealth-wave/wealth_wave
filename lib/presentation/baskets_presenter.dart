import 'package:wealth_wave/core/presenter.dart';
import 'package:wealth_wave/domain/models/basket.dart';
import 'package:wealth_wave/domain/services/basket_service.dart';

class BasketsPresenter extends Presenter<BasketsViewState> {
  final BasketService _basketService;

  BasketsPresenter({final BasketService? basketService})
      : _basketService = basketService ?? BasketService(),
        super(BasketsViewState());

  void fetchBaskets() {
    _basketService.get().then((baskets) => updateViewState((viewState) {
          viewState.baskets = baskets;
        }));
  }

  void deleteBasket({required final int id}) {
    _basketService.deleteBy(id: id).then((_) => fetchBaskets());
  }
}

class BasketsViewState {
  List<Basket> baskets = [];
}
